# -*- coding: utf-8 -*-
# frozen_string_literal: true

# PLEASE DO NOT EDIT THIS FILE, IT IS GENERATED AND WILL BE OVERWRITTEN:
# https://github.com/ccxt/ccxt/blob/master/CONTRIBUTING.md#how-to-contribute-code

module Ccxt
  class Indodax < Exchange
    def describe
      return self.deep_extend(super, {
        'id' => 'indodax',
        'name' => 'INDODAX',
        'countries' => ['ID'], # Indonesia
        'has' => {
          'CORS' => false,
          'createMarketOrder' => false,
          'fetchTickers' => false,
          'fetchOrder' => true,
          'fetchOrders' => false,
          'fetchClosedOrders' => true,
          'fetchOpenOrders' => true,
          'fetchMyTrades' => false,
          'fetchCurrencies' => false,
          'withdraw' => true
        },
        'version' => '1.8', # as of 9 April 2018
        'urls' => {
          'logo' => 'https://user-images.githubusercontent.com/1294454/37443283-2fddd0e4-281c-11e8-9741-b4f1419001b5.jpg',
          'api' => {
            'public' => 'https://indodax.com/api',
            'private' => 'https://indodax.com/tapi'
          },
          'www' => 'https://www.indodax.com',
          'doc' => 'https://indodax.com/downloads/BITCOINCOID-API-DOCUMENTATION.pdf',
          'referral' => 'https://indodax.com/ref/testbitcoincoid/1'
        },
        'api' => {
          'public' => {
            'get' => [
              '{pair}/ticker',
              '{pair}/trades',
              '{pair}/depth'
            ]
          },
          'private' => {
            'post' => [
              'getInfo',
              'transHistory',
              'trade',
              'tradeHistory',
              'getOrder',
              'openOrders',
              'cancelOrder',
              'orderHistory',
              'withdrawCoin'
            ]
          }
        },
        'markets' => {
          # HARDCODING IS DEPRECATED
          # but they don't have a corresponding endpoint in their API
          'BTC/IDR' => { 'id' => 'btc_idr', 'symbol' => 'BTC/IDR', 'base' => 'BTC', 'quote' => 'IDR', 'baseId' => 'btc', 'quoteId' => 'idr', 'precision' => { 'amount' => 8, 'price' => 0 }, 'limits' => { 'amount' => { 'min' => 0.0001, 'max' => nil }}},
          'ACT/IDR' => { 'id' => 'act_idr', 'symbol' => 'ACT/IDR', 'base' => 'ACT', 'quote' => 'IDR', 'baseId' => 'act', 'quoteId' => 'idr', 'precision' => { 'amount' => 8, 'price' => 0 }, 'limits' => { 'amount' => { 'min' => nil, 'max' => nil }}},
          'ADA/IDR' => { 'id' => 'ada_idr', 'symbol' => 'ADA/IDR', 'base' => 'ADA', 'quote' => 'IDR', 'baseId' => 'ada', 'quoteId' => 'idr', 'precision' => { 'amount' => 8, 'price' => 0 }, 'limits' => { 'amount' => { 'min' => nil, 'max' => nil }}},
          'BCD/IDR' => { 'id' => 'bcd_idr', 'symbol' => 'BCD/IDR', 'base' => 'BCD', 'quote' => 'IDR', 'baseId' => 'bcd', 'quoteId' => 'idr', 'precision' => { 'amount' => 8, 'price' => 0 }, 'limits' => { 'amount' => { 'min' => nil, 'max' => nil }}},
          'BCH/IDR' => { 'id' => 'bch_idr', 'symbol' => 'BCH/IDR', 'base' => 'BCH', 'quote' => 'IDR', 'baseId' => 'bch', 'quoteId' => 'idr', 'precision' => { 'amount' => 8, 'price' => 0 }, 'limits' => { 'amount' => { 'min' => 0.001, 'max' => nil }}},
          'BTG/IDR' => { 'id' => 'btg_idr', 'symbol' => 'BTG/IDR', 'base' => 'BTG', 'quote' => 'IDR', 'baseId' => 'btg', 'quoteId' => 'idr', 'precision' => { 'amount' => 8, 'price' => 0 }, 'limits' => { 'amount' => { 'min' => 0.01, 'max' => nil }}},
          'BTS/IDR' => { 'id' => 'bts_idr', 'symbol' => 'BTS/IDR', 'base' => 'BTS', 'quote' => 'IDR', 'baseId' => 'bts', 'quoteId' => 'idr', 'precision' => { 'amount' => 8, 'price' => 0 }, 'limits' => { 'amount' => { 'min' => 0.01, 'max' => nil }}},
          'DASH/IDR' => { 'id' => 'drk_idr', 'symbol' => 'DASH/IDR', 'base' => 'DASH', 'quote' => 'IDR', 'baseId' => 'drk', 'quoteId' => 'idr', 'precision' => { 'amount' => 8, 'price' => 0 }, 'limits' => { 'amount' => { 'min' => 0.01, 'max' => nil }}},
          'DOGE/IDR' => { 'id' => 'doge_idr', 'symbol' => 'DOGE/IDR', 'base' => 'DOGE', 'quote' => 'IDR', 'baseId' => 'doge', 'quoteId' => 'idr', 'precision' => { 'amount' => 8, 'price' => 0 }, 'limits' => { 'amount' => { 'min' => 1000, 'max' => nil }}},
          'ETH/IDR' => { 'id' => 'eth_idr', 'symbol' => 'ETH/IDR', 'base' => 'ETH', 'quote' => 'IDR', 'baseId' => 'eth', 'quoteId' => 'idr', 'precision' => { 'amount' => 8, 'price' => 0 }, 'limits' => { 'amount' => { 'min' => 0.01, 'max' => nil }}},
          'ETC/IDR' => { 'id' => 'etc_idr', 'symbol' => 'ETC/IDR', 'base' => 'ETC', 'quote' => 'IDR', 'baseId' => 'etc', 'quoteId' => 'idr', 'precision' => { 'amount' => 8, 'price' => 0 }, 'limits' => { 'amount' => { 'min' => 0.1, 'max' => nil }}},
          'GSC/IDR' => { 'id' => 'gsc_idr', 'symbol' => 'GSC/IDR', 'base' => 'GSC', 'quote' => 'IDR', 'baseId' => 'gsc', 'quoteId' => 'idr', 'precision' => { 'amount' => 8, 'price' => 0 }, 'limits' => { 'amount' => { 'min' => 0.1, 'max' => nil }}},
          'IGNIS/IDR' => { 'id' => 'ignis_idr', 'symbol' => 'IGNIS/IDR', 'base' => 'IGNIS', 'quote' => 'IDR', 'baseId' => 'ignis', 'quoteId' => 'idr', 'precision' => { 'amount' => 8, 'price' => 0 }, 'limits' => { 'amount' => { 'min' => 1, 'max' => nil }}},
          'LTC/IDR' => { 'id' => 'ltc_idr', 'symbol' => 'LTC/IDR', 'base' => 'LTC', 'quote' => 'IDR', 'baseId' => 'ltc', 'quoteId' => 'idr', 'precision' => { 'amount' => 8, 'price' => 0 }, 'limits' => { 'amount' => { 'min' => 0.01, 'max' => nil }}},
          'NPXS/IDR' => { 'id' => 'npxs_idr', 'symbol' => 'NPXS/IDR', 'base' => 'NPXS', 'quote' => 'IDR', 'baseId' => 'npxs', 'quoteId' => 'idr', 'precision' => { 'amount' => 8, 'price' => 0 }, 'limits' => { 'amount' => { 'min' => 1, 'max' => nil }}},
          'NXT/IDR' => { 'id' => 'nxt_idr', 'symbol' => 'NXT/IDR', 'base' => 'NXT', 'quote' => 'IDR', 'baseId' => 'nxt', 'quoteId' => 'idr', 'precision' => { 'amount' => 8, 'price' => 0 }, 'limits' => { 'amount' => { 'min' => 5, 'max' => nil }}},
          'STQ/IDR' => { 'id' => 'stq_idr', 'symbol' => 'STQ/IDR', 'base' => 'STQ', 'quote' => 'IDR', 'baseId' => 'stq', 'quoteId' => 'idr', 'precision' => { 'amount' => 8, 'price' => 0 }, 'limits' => { 'amount' => { 'min' => nil, 'max' => nil }}},
          'TEN/IDR' => { 'id' => 'ten_idr', 'symbol' => 'TEN/IDR', 'base' => 'TEN', 'quote' => 'IDR', 'baseId' => 'ten', 'quoteId' => 'idr', 'precision' => { 'amount' => 8, 'price' => 0 }, 'limits' => { 'amount' => { 'min' => 5, 'max' => nil }}},
          'TRX/IDR' => { 'id' => 'trx_idr', 'symbol' => 'TRX/IDR', 'base' => 'TRX', 'quote' => 'IDR', 'baseId' => 'trx', 'quoteId' => 'idr', 'precision' => { 'amount' => 8, 'price' => 0 }, 'limits' => { 'amount' => { 'min' => nil, 'max' => nil }}},
          'WAVES/IDR' => { 'id' => 'waves_idr', 'symbol' => 'WAVES/IDR', 'base' => 'WAVES', 'quote' => 'IDR', 'baseId' => 'waves', 'quoteId' => 'idr', 'precision' => { 'amount' => 8, 'price' => 0 }, 'limits' => { 'amount' => { 'min' => 0.1, 'max' => nil }}},
          'XEM/IDR' => { 'id' => 'nem_idr', 'symbol' => 'XEM/IDR', 'base' => 'XEM', 'quote' => 'IDR', 'baseId' => 'nem', 'quoteId' => 'idr', 'precision' => { 'amount' => 8, 'price' => 0 }, 'limits' => { 'amount' => { 'min' => 1, 'max' => nil }}},
          'XLM/IDR' => { 'id' => 'str_idr', 'symbol' => 'XLM/IDR', 'base' => 'XLM', 'quote' => 'IDR', 'baseId' => 'str', 'quoteId' => 'idr', 'precision' => { 'amount' => 8, 'price' => 0 }, 'limits' => { 'amount' => { 'min' => 20, 'max' => nil }}},
          'XRP/IDR' => { 'id' => 'xrp_idr', 'symbol' => 'XRP/IDR', 'base' => 'XRP', 'quote' => 'IDR', 'baseId' => 'xrp', 'quoteId' => 'idr', 'precision' => { 'amount' => 8, 'price' => 0 }, 'limits' => { 'amount' => { 'min' => 10, 'max' => nil }}},
          'XZC/IDR' => { 'id' => 'xzc_idr', 'symbol' => 'XZC/IDR', 'base' => 'XZC', 'quote' => 'IDR', 'baseId' => 'xzc', 'quoteId' => 'idr', 'precision' => { 'amount' => 8, 'price' => 0 }, 'limits' => { 'amount' => { 'min' => 0.1, 'max' => nil }}},
          'BTS/BTC' => { 'id' => 'bts_btc', 'symbol' => 'BTS/BTC', 'base' => 'BTS', 'quote' => 'BTC', 'baseId' => 'bts', 'quoteId' => 'btc', 'precision' => { 'amount' => 8, 'price' => 8 }, 'limits' => { 'amount' => { 'min' => 0.01, 'max' => nil }}},
          'DASH/BTC' => { 'id' => 'drk_btc', 'symbol' => 'DASH/BTC', 'base' => 'DASH', 'quote' => 'BTC', 'baseId' => 'drk', 'quoteId' => 'btc', 'precision' => { 'amount' => 8, 'price' => 6 }, 'limits' => { 'amount' => { 'min' => 0.01, 'max' => nil }}},
          'DOGE/BTC' => { 'id' => 'doge_btc', 'symbol' => 'DOGE/BTC', 'base' => 'DOGE', 'quote' => 'BTC', 'baseId' => 'doge', 'quoteId' => 'btc', 'precision' => { 'amount' => 8, 'price' => 8 }, 'limits' => { 'amount' => { 'min' => 1, 'max' => nil }}},
          'ETH/BTC' => { 'id' => 'eth_btc', 'symbol' => 'ETH/BTC', 'base' => 'ETH', 'quote' => 'BTC', 'baseId' => 'eth', 'quoteId' => 'btc', 'precision' => { 'amount' => 8, 'price' => 5 }, 'limits' => { 'amount' => { 'min' => 0.001, 'max' => nil }}},
          'LTC/BTC' => { 'id' => 'ltc_btc', 'symbol' => 'LTC/BTC', 'base' => 'LTC', 'quote' => 'BTC', 'baseId' => 'ltc', 'quoteId' => 'btc', 'precision' => { 'amount' => 8, 'price' => 6 }, 'limits' => { 'amount' => { 'min' => 0.01, 'max' => nil }}},
          'NXT/BTC' => { 'id' => 'nxt_btc', 'symbol' => 'NXT/BTC', 'base' => 'NXT', 'quote' => 'BTC', 'baseId' => 'nxt', 'quoteId' => 'btc', 'precision' => { 'amount' => 8, 'price' => 8 }, 'limits' => { 'amount' => { 'min' => 0.01, 'max' => nil }}},
          'TEN/BTC' => { 'id' => 'ten_btc', 'symbol' => 'TEN/BTC', 'base' => 'TEN', 'quote' => 'BTC', 'baseId' => 'ten', 'quoteId' => 'btc', 'precision' => { 'amount' => 8, 'price' => 8 }, 'limits' => { 'amount' => { 'min' => 0.01, 'max' => nil }}},
          'XEM/BTC' => { 'id' => 'nem_btc', 'symbol' => 'XEM/BTC', 'base' => 'XEM', 'quote' => 'BTC', 'baseId' => 'nem', 'quoteId' => 'btc', 'precision' => { 'amount' => 8, 'price' => 8 }, 'limits' => { 'amount' => { 'min' => 1, 'max' => nil }}},
          'XLM/BTC' => { 'id' => 'str_btc', 'symbol' => 'XLM/BTC', 'base' => 'XLM', 'quote' => 'BTC', 'baseId' => 'str', 'quoteId' => 'btc', 'precision' => { 'amount' => 8, 'price' => 8 }, 'limits' => { 'amount' => { 'min' => 0.01, 'max' => nil }}},
          'XRP/BTC' => { 'id' => 'xrp_btc', 'symbol' => 'XRP/BTC', 'base' => 'XRP', 'quote' => 'BTC', 'baseId' => 'xrp', 'quoteId' => 'btc', 'precision' => { 'amount' => 8, 'price' => 8 }, 'limits' => { 'amount' => { 'min' => 0.01, 'max' => nil }}}
        },
        'fees' => {
          'trading' => {
            'tierBased' => false,
            'percentage' => true,
            'maker' => 0,
            'taker' => 0.003
          }
        }
      })
    end

    def fetch_balance(params = {})
      self.load_markets
      response = self.privatePostGetInfo
      balance = response['return']
      result = { 'info' => balance }
      codes = self.currencies.keys
      for i in (0...codes.length)
        code = codes[i]
        currency = self.currencies[code]
        lowercase = currency['id']
        account = self.account
        account['free'] = self.safe_float(balance['balance'], lowercase, 0.0)
        account['used'] = self.safe_float(balance['balance_hold'], lowercase, 0.0)
        account['total'] = self.sum(account['free'], account['used'])
        result[code] = account
      end
      return self.parse_balance(result)
    end

    def fetch_order_book(symbol, limit = nil, params = {})
      self.load_markets
      orderbook = self.publicGetPairDepth(self.shallow_extend({
        'pair' => self.market_id(symbol)
      }, params))
      return self.parse_order_book(orderbook, nil, 'buy', 'sell')
    end

    def fetch_ticker(symbol, params = {})
      self.load_markets
      market = self.market(symbol)
      response = self.publicGetPairTicker(self.shallow_extend({
        'pair' => market['id']
      }, params))
      ticker = response['ticker']
      timestamp = self.safe_float(ticker, 'server_time') * 1000
      baseVolume = 'vol_' + market['baseId'].downcase
      quoteVolume = 'vol_' + market['quoteId'].downcase
      last = self.safe_float(ticker, 'last')
      return {
        'symbol' => symbol,
        'timestamp' => timestamp,
        'datetime' => self.iso8601(timestamp),
        'high' => self.safe_float(ticker, 'high'),
        'low' => self.safe_float(ticker, 'low'),
        'bid' => self.safe_float(ticker, 'buy'),
        'bidVolume' => nil,
        'ask' => self.safe_float(ticker, 'sell'),
        'askVolume' => nil,
        'vwap' => nil,
        'open' => nil,
        'close' => last,
        'last' => last,
        'previousClose' => nil,
        'change' => nil,
        'percentage' => nil,
        'average' => nil,
        'baseVolume' => self.safe_float(ticker, baseVolume),
        'quoteVolume' => self.safe_float(ticker, quoteVolume),
        'info' => ticker
      }
    end

    def parse_trade(trade, market)
      timestamp = parse_int(trade['date']) * 1000
      return {
        'id' => trade['tid'],
        'info' => trade,
        'timestamp' => timestamp,
        'datetime' => self.iso8601(timestamp),
        'symbol' => market['symbol'],
        'type' => nil,
        'side' => trade['type'],
        'price' => self.safe_float(trade, 'price'),
        'amount' => self.safe_float(trade, 'amount')
      }
    end

    def fetch_trades(symbol, since = nil, limit = nil, params = {})
      self.load_markets
      market = self.market(symbol)
      response = self.publicGetPairTrades(self.shallow_extend({
        'pair' => market['id']
      }, params))
      return self.parse_trades(response, market, since, limit)
    end

    def parse_order(order, market = nil)
      side = nil
      if order.include?('type')
        side = order['type']
      end
      status = self.safe_string(order, 'status', 'open')
      if status == 'filled'
        status = 'closed'
      elsif status == 'calcelled'
        status = 'canceled'
      end
      symbol = nil
      cost = nil
      price = self.safe_float(order, 'price')
      amount = nil
      remaining = nil
      filled = nil
      if market != nil
        symbol = market['symbol']
        quoteId = market['quoteId']
        baseId = market['baseId']
        if (market['quoteId'] == 'idr') && (order.include?('order_rp'))
          quoteId = 'rp'
        end
        if (market['baseId'] == 'idr') && (order.include?('remain_rp'))
          baseId = 'rp'
        end
        cost = self.safe_float(order, 'order_' + quoteId)
        if cost
          amount = cost / price
          remainingCost = self.safe_float(order, 'remain_' + quoteId)
          if remainingCost != nil
            remaining = remainingCost / price
            filled = amount - remaining
          end
        else
          amount = self.safe_float(order, 'order_' + baseId)
          cost = price * amount
          remaining = self.safe_float(order, 'remain_' + baseId)
          filled = amount - remaining
        end
      end
      average = nil
      if filled
        average = cost / filled
      end
      timestamp = parse_int(order['submit_time'])
      fee = nil
      result = {
        'info' => order,
        'id' => order['order_id'],
        'timestamp' => timestamp,
        'datetime' => self.iso8601(timestamp),
        'lastTradeTimestamp' => nil,
        'symbol' => symbol,
        'type' => 'limit',
        'side' => side,
        'price' => price,
        'cost' => cost,
        'average' => average,
        'amount' => amount,
        'filled' => filled,
        'remaining' => remaining,
        'status' => status,
        'fee' => fee
      }
      return result
    end

    def fetch_order(id, symbol = nil, params = {})
      if symbol.nil?
        raise(ExchangeError, self.id + ' fetchOrder requires a symbol')
      end
      self.load_markets
      market = self.market(symbol)
      response = self.privatePostGetOrder(self.shallow_extend({
        'pair' => market['id'],
        'order_id' => id
      }, params))
      orders = response['return']
      order = self.parse_order(self.shallow_extend({ 'id' => id }, orders['order']), market)
      return self.shallow_extend({ 'info' => response }, order)
    end

    def fetch_open_orders(symbol = nil, since = nil, limit = nil, params = {})
      self.load_markets
      market = nil
      request = {}
      if symbol != nil
        market = self.market(symbol)
        request['pair'] = market['id']
      end
      response = self.privatePostOpenOrders(self.shallow_extend(request, params))
      rawOrders = response['return']['orders']
      # { success => 1, return => { orders => null }} if no orders
      if !rawOrders
        return []
      end
      # { success => 1, return => { orders => [... objects] }} for orders fetched by symbol
      if symbol != nil
        return self.parse_orders(rawOrders, market, since, limit)
      end
      # { success => 1, return => { orders => { marketid => [... objects] }}} if all orders are fetched
      marketIds = rawOrders.keys
      exchangeOrders = []
      for i in (0...marketIds.length)
        marketId = marketIds[i]
        marketOrders = rawOrders[marketId]
        market = self.markets_by_id[marketId]
        parsedOrders = self.parse_orders(marketOrders, market, since, limit)
        exchangeOrders = self.array_concat(exchangeOrders, parsedOrders)
      end
      return exchangeOrders
    end

    def fetch_closed_orders(symbol = nil, since = nil, limit = nil, params = {})
      if symbol.nil?
        raise(ExchangeError, self.id + ' fetchOrders requires a symbol')
      end
      self.load_markets
      request = {}
      market = nil
      if symbol != nil
        market = self.market(symbol)
        request['pair'] = market['id']
      end
      response = self.privatePostOrderHistory(self.shallow_extend(request, params))
      orders = self.parse_orders(response['return']['orders'], market, since, limit)
      orders = self.filter_by(orders, 'status', 'closed')
      if symbol != nil
        return self.filter_by_symbol(orders, symbol)
      end
      return orders
    end

    def create_order(symbol, type, side, amount, price = nil, params = {})
      if type != 'limit'
        raise(ExchangeError, self.id + ' allows limit orders only')
      end
      self.load_markets
      market = self.market(symbol)
      order = {
        'pair' => market['id'],
        'type' => side,
        'price' => price
      }
      currency = market['baseId']
      if side == 'buy'
        order[market['quoteId']] = amount * price
      else
        order[market['baseId']] = amount
      end
      order[currency] = amount
      result = self.privatePostTrade(self.shallow_extend(order, params))
      return {
        'info' => result,
        'id' => result['return']['order_id'].to_s
      }
    end

    def cancel_order(id, symbol = nil, params = {})
      if symbol.nil?
        raise(ArgumentsRequired, self.id + ' cancelOrder requires a symbol argument')
      end
      side = self.safe_value(params, 'side')
      if side.nil?
        raise(ExchangeError, self.id + ' cancelOrder requires an extra "side" param')
      end
      self.load_markets
      market = self.market(symbol)
      return self.privatePostCancelOrder(self.shallow_extend({
        'order_id' => id,
        'pair' => market['id'],
        'type' => params['side']
      }, params))
    end

    def withdraw(code, amount, address, tag = nil, params = {})
      self.check_address(address)
      self.load_markets
      currency = self.currency(code)
      # Custom string you need to provide to identify each withdrawal.
      # Will be passed to callback URL(assigned via website to the API key)
      # so your system can identify the request and confirm it.
      # Alphanumeric, max length 255.
      requestId = self.milliseconds
      # Alternatively:
      # requestId = self.uuid
      request = {
        'currency' => currency['id'],
        'withdraw_amount' => amount,
        'withdraw_address' => address,
        'request_id' => requestId.to_s
      }
      if tag
        request['withdraw_memo'] = tag
      end
      response = self.privatePostWithdrawCoin(self.shallow_extend(request, params))
      #
      #     {
      #         "success" => 1,
      #         "status" => "approved",
      #         "withdraw_currency" => "xrp",
      #         "withdraw_address" => "rwWr7KUZ3ZFwzgaDGjKBysADByzxvohQ3C",
      #         "withdraw_amount" => "10000.00000000",
      #         "fee" => "2.00000000",
      #         "amount_after_fee" => "9998.00000000",
      #         "submit_time" => "1509469200",
      #         "withdraw_id" => "xrp-12345",
      #         "txid" => "",
      #         "withdraw_memo" => "123123"
      #     }
      #
      id = nil
      if response.include?(('txid')) && (response['txid'].length > 0)
        id = response['txid']
      end
      return {
        'info' => response,
        'id' => id
      }
    end

    def sign(path, api = 'public', method = 'GET', params = {}, headers = nil, body = nil)
      url = self.urls['api'][api]
      if api == 'public'
        url += '/' + self.implode_params(path, params)
      else
        self.check_required_credentials
        body = self.urlencode(self.shallow_extend({
          'method' => path,
          'nonce' => self.nonce
        }, params))
        headers = {
          'Content-Type' => 'application/x-www-form-urlencoded',
          'Key' => self.apiKey,
          'Sign' => self.hmac(self.encode(body), self.encode(self.secret), 'sha512')
        }
      end
      return { 'url' => url, 'method' => method, 'body' => body, 'headers' => headers }
    end

    def handle_errors(code, reason, url, method, headers, body, response)
      if !body.is_a?(String)
        return
      end
      # { success => 0, error => "invalid order." }
      # or
      # [{ data, ... }, { ... }, ...]
      if response.is_a?(Array)
        return
      end # public endpoints may return []-arrays
      if !(response.include?('success'))
        return
      end # no 'success' property on public responses
      if response['success'] == 1
        # { success => 1, return => { orders => [] }}
        if !(response.include?('return'))
          raise(ExchangeError, self.id + ' => malformed response => ' + self.json(response))
        else
          return
        end
      end
      message = response['error']
      feedback = self.id + ' ' + self.json(response)
      if message == 'Insufficient balance.'
        raise(InsufficientFunds, feedback)
      elsif message == 'invalid order.'
        raise(OrderNotFound, feedback) # cancelOrder(1)
      elsif message.include?('Minimum price ')
        raise(InvalidOrder, feedback) # price < limits.price.min, on createLimitBuyOrder('ETH/BTC', 1, 0)
      elsif message.include?('Minimum order ')
        raise(InvalidOrder, feedback) # cost < limits.cost.min on createLimitBuyOrder('ETH/BTC', 0, 1)
      elsif message == 'Invalid credentials. API not found or session has expired.'
        raise(AuthenticationError, feedback) # on bad apiKey
      elsif message == 'Invalid credentials. Bad sign.'
        raise(AuthenticationError, feedback) # on bad secret
      end
      raise(ExchangeError, self.id + ' => unknown error => ' + self.json(response))
    end
  end
end
