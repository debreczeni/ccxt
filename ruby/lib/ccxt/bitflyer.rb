# -*- coding: utf-8 -*-
# frozen_string_literal: true

# PLEASE DO NOT EDIT THIS FILE, IT IS GENERATED AND WILL BE OVERWRITTEN:
# https://github.com/ccxt/ccxt/blob/master/CONTRIBUTING.md#how-to-contribute-code

module Ccxt
  class Bitflyer < Exchange
    def describe
      return self.deep_extend(super, {
        'id' => 'bitflyer',
        'name' => 'bitFlyer',
        'countries' => ['JP'],
        'version' => 'v1',
        'rateLimit' => 1000, # their nonce-timestamp is in seconds...
        'has' => {
          'CORS' => false,
          'withdraw' => true,
          'fetchMyTrades' => true,
          'fetchOrders' => true,
          'fetchOrder' => true,
          'fetchOpenOrders' => 'emulated',
          'fetchClosedOrders' => 'emulated'
        },
        'urls' => {
          'logo' => 'https://user-images.githubusercontent.com/1294454/28051642-56154182-660e-11e7-9b0d-6042d1e6edd8.jpg',
          'api' => 'https://api.bitflyer.jp',
          'www' => 'https://bitflyer.jp',
          'doc' => 'https://lightning.bitflyer.com/docs?lang=en'
        },
        'api' => {
          'public' => {
            'get' => [
              'getmarkets/usa', # new(wip)
              'getmarkets/eu',  # new(wip)
              'getmarkets',     # or 'markets'
              'getboard',       # ...
              'getticker',
              'getexecutions',
              'gethealth',
              'getboardstate',
              'getchats'
            ]
          },
          'private' => {
            'get' => [
              'getpermissions',
              'getbalance',
              'getbalancehistory',
              'getcollateral',
              'getcollateralhistory',
              'getcollateralaccounts',
              'getaddresses',
              'getcoinins',
              'getcoinouts',
              'getbankaccounts',
              'getdeposits',
              'getwithdrawals',
              'getchildorders',
              'getparentorders',
              'getparentorder',
              'getexecutions',
              'getpositions',
              'gettradingcommission'
            ],
            'post' => [
              'sendcoin',
              'withdraw',
              'sendchildorder',
              'cancelchildorder',
              'sendparentorder',
              'cancelparentorder',
              'cancelallchildorders'
            ]
          }
        },
        'fees' => {
          'trading' => {
            'maker' => 0.25 / 100,
            'taker' => 0.25 / 100
          }
        }
      })
    end

    def fetch_markets(params = {})
      jp_markets = self.publicGetGetmarkets
      us_markets = self.publicGetGetmarketsUsa
      eu_markets = self.publicGetGetmarketsEu
      markets = self.array_concat(jp_markets, us_markets)
      markets = self.array_concat(markets, eu_markets)
      result = []
      for p in (0...markets.length)
        market = markets[p]
        id = market['product_code']
        spot = true
        future = false
        type = 'spot'
        if market.include?('alias')
          type = 'future'
          future = true
          spot = false
        end
        currencies = id.split('_')
        baseId = nil
        quoteId = nil
        base = nil
        quote = nil
        numCurrencies = currencies.length
        if numCurrencies == 1
          baseId = id[0...3]
          quoteId = id[3...6]
        elsif numCurrencies == 2
          baseId = currencies[0]
          quoteId = currencies[1]
        else
          baseId = currencies[1]
          quoteId = currencies[2]
        end
        base = self.common_currency_code(baseId)
        quote = self.common_currency_code(quoteId)
        symbol = (numCurrencies == 2) ?(base + '/' + quote) : id
        result.push({
          'id' => id,
          'symbol' => symbol,
          'base' => base,
          'quote' => quote,
          'baseId' => baseId,
          'quoteId' => quoteId,
          'type' => type,
          'spot' => spot,
          'future' => future,
          'info' => market
        })
      end
      return result
    end

    def fetch_balance(params = {})
      self.load_markets
      response = self.privateGetGetbalance
      balances = {}
      for b in (0...response.length)
        account = response[b]
        currency = account['currency_code']
        balances[currency] = account
      end
      result = { 'info' => response }
      currencies = self.currencies.keys
      for i in (0...currencies.length)
        currency = currencies[i]
        account = self.account
        if balances.include?(currency)
          account['total'] = balances[currency]['amount']
          account['free'] = balances[currency]['available']
          account['used'] = account['total'] - account['free']
        end
        result[currency] = account
      end
      return self.parse_balance(result)
    end

    def fetch_order_book(symbol, limit = nil, params = {})
      self.load_markets
      orderbook = self.publicGetGetboard(self.shallow_extend({
        'product_code' => self.market_id(symbol)
      }, params))
      return self.parse_order_book(orderbook, nil, 'bids', 'asks', 'price', 'size')
    end

    def fetch_ticker(symbol, params = {})
      self.load_markets
      ticker = self.publicGetGetticker(self.shallow_extend({
        'product_code' => self.market_id(symbol)
      }, params))
      timestamp = self.parse8601(ticker['timestamp'])
      last = self.safe_float(ticker, 'ltp')
      return {
        'symbol' => symbol,
        'timestamp' => timestamp,
        'datetime' => self.iso8601(timestamp),
        'high' => nil,
        'low' => nil,
        'bid' => self.safe_float(ticker, 'best_bid'),
        'bidVolume' => nil,
        'ask' => self.safe_float(ticker, 'best_ask'),
        'askVolume' => nil,
        'vwap' => nil,
        'open' => nil,
        'close' => last,
        'last' => last,
        'previousClose' => nil,
        'change' => nil,
        'percentage' => nil,
        'average' => nil,
        'baseVolume' => self.safe_float(ticker, 'volume_by_product'),
        'quoteVolume' => nil,
        'info' => ticker
      }
    end

    def parse_trade(trade, market = nil)
      side = nil
      order = nil
      if trade.include?('side')
        if trade['side']
          side = trade['side'].downcase
          id = side + '_child_order_acceptance_id'
          if trade.include?(id)
            order = trade[id]
          end
        end
      end
      if order.nil?
        order = self.safe_string(trade, 'child_order_acceptance_id')
      end
      timestamp = self.parse8601(trade['exec_date'])
      price = self.safe_float(trade, 'price')
      amount = self.safe_float(trade, 'size')
      return {
        'id' => trade['id'].to_s,
        'info' => trade,
        'timestamp' => timestamp,
        'datetime' => self.iso8601(timestamp),
        'symbol' => market['symbol'],
        'order' => order,
        'type' => nil,
        'side' => side,
        'price' => price,
        'amount' => amount
      }
    end

    def fetch_trades(symbol, since = nil, limit = nil, params = {})
      self.load_markets
      market = self.market(symbol)
      response = self.publicGetGetexecutions(self.shallow_extend({
        'product_code' => market['id']
      }, params))
      return self.parse_trades(response, market, since, limit)
    end

    def create_order(symbol, type, side, amount, price = nil, params = {})
      self.load_markets
      order = {
        'product_code' => self.market_id(symbol),
        'child_order_type' => type.upcase,
        'side' => side.upcase,
        'price' => price,
        'size' => amount
      }
      result = self.privatePostSendchildorder(self.shallow_extend(order, params))
      # { "status" => - 200, "error_message" => "Insufficient funds", "data" => null }
      return {
        'info' => result,
        'id' => result['child_order_acceptance_id']
      }
    end

    def cancel_order(id, symbol = nil, params = {})
      if symbol.nil?
        raise(ArgumentsRequired, self.id + ' cancelOrder requires a symbol argument')
      end
      self.load_markets
      return self.privatePostCancelchildorder(self.shallow_extend({
        'product_code' => self.market_id(symbol),
        'child_order_acceptance_id' => id
      }, params))
    end

    def parse_order_status(status)
      statuses = {
        'ACTIVE' => 'open',
        'COMPLETED' => 'closed',
        'CANCELED' => 'canceled',
        'EXPIRED' => 'canceled',
        'REJECTED' => 'canceled'
      }
      if statuses.include?(status)
        return statuses[status]
      end
      return status
    end

    def parse_order(order, market = nil)
      timestamp = self.parse8601(order['child_order_date'])
      amount = self.safe_float(order, 'size')
      remaining = self.safe_float(order, 'outstanding_size')
      filled = self.safe_float(order, 'executed_size')
      price = self.safe_float(order, 'price')
      cost = price * filled
      status = self.parse_order_status(self.safe_string(order, 'child_order_state'))
      type = order['child_order_type'].downcase
      side = order['side'].downcase
      symbol = nil
      if market.nil?
        marketId = self.safe_string(order, 'product_code')
        if marketId != nil
          if self.markets_by_id.include?(marketId)
            market = self.markets_by_id[marketId]
          end
        end
      end
      if market != nil
        symbol = market['symbol']
      end
      fee = nil
      feeCost = self.safe_float(order, 'total_commission')
      if feeCost != nil
        fee = {
          'cost' => feeCost,
          'currency' => nil,
          'rate' => nil
        }
      end
      return {
        'id' => order['child_order_acceptance_id'],
        'info' => order,
        'timestamp' => timestamp,
        'datetime' => self.iso8601(timestamp),
        'lastTradeTimestamp' => nil,
        'status' => status,
        'symbol' => symbol,
        'type' => type,
        'side' => side,
        'price' => price,
        'cost' => cost,
        'amount' => amount,
        'filled' => filled,
        'remaining' => remaining,
        'fee' => fee
      }
    end

    def fetch_orders(symbol = nil, since = nil, limit = 100, params = {})
      if symbol.nil?
        raise(ArgumentsRequired, self.id + ' fetchOrders requires a symbol argument')
      end
      self.load_markets
      market = self.market(symbol)
      request = {
        'product_code' => market['id'],
        'count' => limit
      }
      response = self.privateGetGetchildorders(self.shallow_extend(request, params))
      orders = self.parse_orders(response, market, since, limit)
      if symbol != nil
        orders = self.filter_by(orders, 'symbol', symbol)
      end
      return orders
    end

    def fetch_open_orders(symbol = nil, since = nil, limit = 100, params = {})
      request = {
        'child_order_state' => 'ACTIVE'
      }
      return self.fetch_orders(symbol, since, limit, self.shallow_extend(request, params))
    end

    def fetch_closed_orders(symbol = nil, since = nil, limit = 100, params = {})
      request = {
        'child_order_state' => 'COMPLETED'
      }
      return self.fetch_orders(symbol, since, limit, self.shallow_extend(request, params))
    end

    def fetch_order(id, symbol = nil, params = {})
      if symbol.nil?
        raise(ArgumentsRequired, self.id + ' fetchOrder requires a symbol argument')
      end
      orders = self.fetch_orders(symbol)
      ordersById = self.index_by(orders, 'id')
      if ordersById.include?(id)
        return ordersById[id]
      end
      raise(OrderNotFound, self.id + ' No order found with id ' + id)
    end

    def fetch_my_trades(symbol = nil, since = nil, limit = nil, params = {})
      if symbol.nil?
        raise(ArgumentsRequired, self.id + ' fetchMyTrades requires a symbol argument')
      end
      self.load_markets
      market = self.market(symbol)
      request = {
        'product_code' => market['id']
      }
      if limit != nil
        request['count'] = limit
      end
      response = self.privateGetGetexecutions(self.shallow_extend(request, params))
      return self.parse_trades(response, market, since, limit)
    end

    def withdraw(code, amount, address, tag = nil, params = {})
      self.check_address(address)
      self.load_markets
      if code != 'JPY' && code != 'USD' && code != 'EUR'
        raise(ExchangeError, self.id + ' allows withdrawing JPY, USD, EUR only, ' + code + ' is not supported')
      end
      currency = self.currency(code)
      response = self.privatePostWithdraw(self.shallow_extend({
        'currency_code' => currency['id'],
        'amount' => amount,
        # 'bank_account_id' => 1234
      }, params))
      return {
        'info' => response,
        'id' => response['message_id']
      }
    end

    def sign(path, api = 'public', method = 'GET', params = {}, headers = nil, body = nil)
      request = '/' + self.version + '/'
      if api == 'private'
        request += 'me/'
      end
      request += path
      if method == 'GET'
        if params
          request += '?' + self.urlencode(params)
        end
      end
      url = self.urls['api'] + request
      if api == 'private'
        self.check_required_credentials
        nonce = self.nonce.to_s
        auth = ''.join([nonce, method, request])
        if params
          if method != 'GET'
            body = self.json(params)
            auth += body
          end
        end
        headers = {
          'ACCESS-KEY' => self.apiKey,
          'ACCESS-TIMESTAMP' => nonce,
          'ACCESS-SIGN' => self.hmac(self.encode(auth), self.encode(self.secret)),
          'Content-Type' => 'application/json'
        }
      end
      return { 'url' => url, 'method' => method, 'body' => body, 'headers' => headers }
    end
  end
end
