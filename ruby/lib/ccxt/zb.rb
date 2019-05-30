# -*- coding: utf-8 -*-
# frozen_string_literal: true

# PLEASE DO NOT EDIT THIS FILE, IT IS GENERATED AND WILL BE OVERWRITTEN:
# https://github.com/ccxt/ccxt/blob/master/CONTRIBUTING.md#how-to-contribute-code

module Ccxt
  class Zb < Exchange
    def describe
      return self.class.deep_extend(super, {
        'id' => 'zb',
        'name' => 'ZB',
        'countries' => ['CN'],
        'rateLimit' => 1000,
        'version' => 'v1',
        'has' => {
          'CORS' => false,
          'createMarketOrder' => false,
          'fetchDepositAddress' => true,
          'fetchOrder' => true,
          'fetchOrders' => true,
          'fetchOpenOrders' => true,
          'fetchOHLCV' => true,
          'fetchTickers' => true,
          'withdraw' => true
        },
        'timeframes' => {
          '1m' => '1min',
          '3m' => '3min',
          '5m' => '5min',
          '15m' => '15min',
          '30m' => '30min',
          '1h' => '1hour',
          '2h' => '2hour',
          '4h' => '4hour',
          '6h' => '6hour',
          '12h' => '12hour',
          '1d' => '1day',
          '3d' => '3day',
          '1w' => '1week'
        },
        'exceptions' => {
          # '1000' => 'Successful operation',
          '1001' => ExchangeError, # 'General error message',
          '1002' => ExchangeError, # 'Internal error',
          '1003' => AuthenticationError, # 'Verification does not pass',
          '1004' => AuthenticationError, # 'Funding security password lock',
          '1005' => AuthenticationError, # 'Funds security password is incorrect, please confirm and re-enter.',
          '1006' => AuthenticationError, # 'Real-name certification pending approval or audit does not pass',
          '1009' => ExchangeNotAvailable, # 'This interface is under maintenance',
          '2001' => InsufficientFunds, # 'Insufficient CNY Balance',
          '2002' => InsufficientFunds, # 'Insufficient BTC Balance',
          '2003' => InsufficientFunds, # 'Insufficient LTC Balance',
          '2005' => InsufficientFunds, # 'Insufficient ETH Balance',
          '2006' => InsufficientFunds, # 'Insufficient ETC Balance',
          '2007' => InsufficientFunds, # 'Insufficient BTS Balance',
          '2009' => InsufficientFunds, # 'Account balance is not enough',
          '3001' => OrderNotFound, # 'Pending orders not found',
          '3002' => InvalidOrder, # 'Invalid price',
          '3003' => InvalidOrder, # 'Invalid amount',
          '3004' => AuthenticationError, # 'User does not exist',
          '3005' => ExchangeError, # 'Invalid parameter',
          '3006' => AuthenticationError, # 'Invalid IP or inconsistent with the bound IP',
          '3007' => AuthenticationError, # 'The request time has expired',
          '3008' => OrderNotFound, # 'Transaction records not found',
          '4001' => ExchangeNotAvailable, # 'API interface is locked or not enabled',
          '4002' => DDoSProtection, # 'Request too often'
        },
        'urls' => {
          'logo' => 'https://user-images.githubusercontent.com/1294454/32859187-cd5214f0-ca5e-11e7-967d-96568e2e2bd1.jpg',
          'api' => {
            'public' => 'http://api.zb.cn/data', # no https for public API
            'private' => 'https://trade.zb.cn/api'
          },
          'www' => 'https://www.zb.com',
          'doc' => 'https://www.zb.com/i/developer',
          'fees' => 'https://www.zb.com/i/rate',
          'referral' => 'https://vip.zb.com/user/register?recommendCode=bn070u'
        },
        'api' => {
          'public' => {
            'get' => [
              'markets',
              'ticker',
              'allTicker',
              'depth',
              'trades',
              'kline'
            ]
          },
          'private' => {
            'get' => [
              # spot API
              'order',
              'cancelOrder',
              'getOrder',
              'getOrders',
              'getOrdersNew',
              'getOrdersIgnoreTradeType',
              'getUnfinishedOrdersIgnoreTradeType',
              'getAccountInfo',
              'getUserAddress',
              'getWithdrawAddress',
              'getWithdrawRecord',
              'getChargeRecord',
              'getCnyWithdrawRecord',
              'getCnyChargeRecord',
              'withdraw',
              # leverage API
              'getLeverAssetsInfo',
              'getLeverBills',
              'transferInLever',
              'transferOutLever',
              'loan',
              'cancelLoan',
              'getLoans',
              'getLoanRecords',
              'borrow',
              'repay',
              'getRepayments'
            ]
          }
        },
        'fees' => {
          'funding' => {
            'withdraw' => {
              'BTC' => 0.0001,
              'BCH' => 0.0006,
              'LTC' => 0.005,
              'ETH' => 0.01,
              'ETC' => 0.01,
              'BTS' => 3,
              'EOS' => 1,
              'QTUM' => 0.01,
              'HSR' => 0.001,
              'XRP' => 0.1,
              'USDT' => '0.1%',
              'QCASH' => 5,
              'DASH' => 0.002,
              'BCD' => 0,
              'UBTC' => 0,
              'SBTC' => 0,
              'INK' => 20,
              'TV' => 0.1,
              'BTH' => 0,
              'BCX' => 0,
              'LBTC' => 0,
              'CHAT' => 20,
              'bitCNY' => 20,
              'HLC' => 20,
              'BTP' => 0,
              'BCW' => 0
            }
          },
          'trading' => {
            'maker' => 0.2 / 100,
            'taker' => 0.2 / 100
          }
        },
        'commonCurrencies' => {
          'ENT' => 'ENTCash'
        }
      })
    end

    def fetch_markets(params = {})
      markets = self.publicGetMarkets
      keys = markets.keys
      result = []
      for i in (0...keys.length)
        id = keys[i]
        market = markets[id]
        baseId, quoteId = id.split('_')
        base = self.common_currency_code(baseId.upcase)
        quote = self.common_currency_code(quoteId.upcase)
        symbol = base + '/' + quote
        precision = {
          'amount' => market['amountScale'],
          'price' => market['priceScale']
        }
        result.push({
          'id' => id,
          'symbol' => symbol,
          'baseId' => baseId,
          'quoteId' => quoteId,
          'base' => base,
          'quote' => quote,
          'active' => true,
          'precision' => precision,
          'limits' => {
            'amount' => {
              'min' => 10**-precision['amount'],
              'max' => nil
            },
            'price' => {
              'min' => 10**-precision['price'],
              'max' => nil
            },
            'cost' => {
              'min' => 0,
              'max' => nil
            }
          },
          'info' => market
        })
      end
      return result
    end

    def fetch_balance(params = {})
      self.load_markets
      response = self.privateGetGetAccountInfo(params)
      # todo => use self somehow
      # permissions = response['result']['base']
      balances = response['result']['coins']
      result = { 'info' => response }
      for i in (0...balances.length)
        balance = balances[i]
        #     {        enName => "BTC",
        #               freez => "0.00000000",
        #         unitDecimal =>  8, # always 8
        #              cnName => "BTC",
        #       isCanRecharge =>  true, # TODO => should use self
        #             unitTag => "฿",
        #       isCanWithdraw =>  true,  # TODO => should use self
        #           available => "0.00000000",
        #                 key => "btc"         }
        account = self.account
        currency = balance['key']
        if self.currencies_by_id.include?(currency)
          currency = self.currencies_by_id[currency]['code']
        else
          currency = self.common_currency_code(balance['enName'])
        end
        account['free'] = balance['available'].to_f
        account['used'] = balance['freez'].to_f
        account['total'] = self.class.sum(account['free'], account['used'])
        result[currency] = account
      end
      return self.parse_balance(result)
    end

    def get_market_field_name
      return 'market'
    end

    def fetch_deposit_address(code, params = {})
      self.load_markets
      currency = self.currency(code)
      response = self.privateGetGetUserAddress({
        'currency' => currency['id']
      })
      address = response['message']['datas']['key']
      tag = nil
      if address.index('_')
        arr = address.split('_')
        address = arr[0]  # WARNING => MAY BE tag_address INSTEAD OF address_tag FOR SOME CURRENCIES!!
        tag = arr[1]
      end
      return {
        'currency' => code,
        'address' => address,
        'tag' => tag,
        'info' => response
      }
    end

    def fetch_order_book(symbol, limit = nil, params = {})
      self.load_markets
      market = self.market(symbol)
      marketFieldName = self.get_market_field_name
      request = {}
      request[marketFieldName] = market['id']
      orderbook = self.publicGetDepth(self.class.shallow_extend(request, params))
      return self.parse_order_book(orderbook)
    end

    def fetch_tickers(symbols = nil, params = {})
      self.load_markets
      response = self.publicGetAllTicker(params)
      result = {}
      anotherMarketsById = {}
      marketIds = self.marketsById.keys
      for i in (0...marketIds.length)
        tickerId = marketIds[i].gsub('_', '')
        anotherMarketsById[tickerId] = self.marketsById[marketIds[i]]
      end
      ids = response.keys
      for i in (0...ids.length)
        market = anotherMarketsById[ids[i]]
        result[market['symbol']] = self.parse_ticker(response[ids[i]], market)
      end
      return result
    end

    def fetch_ticker(symbol, params = {})
      self.load_markets
      market = self.market(symbol)
      marketFieldName = self.get_market_field_name
      request = {}
      request[marketFieldName] = market['id']
      response = self.publicGetTicker(self.class.shallow_extend(request, params))
      ticker = response['ticker']
      return self.parse_ticker(ticker, market)
    end

    def parse_ticker(ticker, market = nil)
      timestamp = self.class.milliseconds
      symbol = nil
      if market != nil
        symbol = market['symbol']
      end
      last = self.class.safe_float(ticker, 'last')
      return {
        'symbol' => symbol,
        'timestamp' => timestamp,
        'datetime' => self.class.iso8601(timestamp),
        'high' => self.class.safe_float(ticker, 'high'),
        'low' => self.class.safe_float(ticker, 'low'),
        'bid' => self.class.safe_float(ticker, 'buy'),
        'bidVolume' => nil,
        'ask' => self.class.safe_float(ticker, 'sell'),
        'askVolume' => nil,
        'vwap' => nil,
        'open' => nil,
        'close' => last,
        'last' => last,
        'previousClose' => nil,
        'change' => nil,
        'percentage' => nil,
        'average' => nil,
        'baseVolume' => self.class.safe_float(ticker, 'vol'),
        'quoteVolume' => nil,
        'info' => ticker
      }
    end

    def fetch_ohlcv(symbol, timeframe = '1m', since = nil, limit = nil, params = {})
      self.load_markets
      market = self.market(symbol)
      if limit.nil?
        limit = 1000
      end
      request = {
        'market' => market['id'],
        'type' => self.timeframes[timeframe],
        'limit' => limit
      }
      if since != nil
        request['since'] = since
      end
      response = self.publicGetKline(self.class.shallow_extend(request, params))
      data = self.class.safe_value(response, 'data', [])
      return self.parse_ohlcvs(data, market, timeframe, since, limit)
    end

    def parse_trade(trade, market = nil)
      timestamp = trade['date'] * 1000
      side = (trade['trade_type'] == 'bid') ? 'buy' : 'sell'
      return {
        'info' => trade,
        'id' => trade['tid'].to_s,
        'timestamp' => timestamp,
        'datetime' => self.class.iso8601(timestamp),
        'symbol' => market['symbol'],
        'type' => nil,
        'side' => side,
        'price' => self.class.safe_float(trade, 'price'),
        'amount' => self.class.safe_float(trade, 'amount')
      }
    end

    def fetch_trades(symbol, since = nil, limit = nil, params = {})
      self.load_markets
      market = self.market(symbol)
      marketFieldName = self.get_market_field_name
      request = {}
      request[marketFieldName] = market['id']
      response = self.publicGetTrades(self.class.shallow_extend(request, params))
      return self.parse_trades(response, market, since, limit)
    end

    def create_order(symbol, type, side, amount, price = nil, params = {})
      if type != 'limit'
        raise(InvalidOrder, self.id + ' allows limit orders only')
      end
      self.load_markets
      order = {
        'price' => self.price_to_precision(symbol, price),
        'amount' => self.amount_to_precision(symbol, amount),
        'tradeType' => (side == 'buy') ? '1' : '0',
        'currency' => self.market_id(symbol)
      }
      response = self.privateGetOrder(self.class.shallow_extend(order, params))
      return {
        'info' => response,
        'id' => response['id']
      }
    end

    def cancel_order(id, symbol = nil, params = {})
      self.load_markets
      order = {
        'id' => id.to_s,
        'currency' => self.market_id(symbol)
      }
      order = self.class.shallow_extend(order, params)
      return self.privateGetCancelOrder(order)
    end

    def fetch_order(id, symbol = nil, params = {})
      if symbol.nil?
        raise(ArgumentsRequired, self.id + ' fetchOrder requires a symbol argument')
      end
      self.load_markets
      order = {
        'id' => id.to_s,
        'currency' => self.market_id(symbol)
      }
      order = self.class.shallow_extend(order, params)
      response = self.privateGetGetOrder(order)
      #
      #     {
      #         'total_amount' => 0.01,
      #         'id' => '20180910244276459',
      #         'price' => 180.0,
      #         'trade_date' => 1536576744960,
      #         'status' => 2,
      #         'trade_money' => '1.96742',
      #         'trade_amount' => 0.01,
      #         'type' => 0,
      #         'currency' => 'eth_usdt'
      #     }
      #
      return self.parse_order(response, nil)
    end

    def fetch_orders(symbol = nil, since = nil, limit = 50, params = {})
      if symbol.nil?
        raise(ExchangeError, self.id + 'fetchOrders requires a symbol parameter')
      end
      self.load_markets
      market = self.market(symbol)
      request = {
        'currency' => market['id'],
        'pageIndex' => 1, # default pageIndex is 1
        'pageSize' => limit, # default pageSize is 50
      }
      method = 'privateGetGetOrdersIgnoreTradeType'
      # tradeType 交易类型1/0[buy/sell]
      if params.include?('tradeType')
        method = 'privateGetGetOrdersNew'
      end
      response = nil
      begin
        response = self.send_wrapper(method, self.class.shallow_extend(request, params))
      rescue BaseError => e
        if e.is_a?(OrderNotFound)
          return []
        end
        raise e
      end
      return self.parse_orders(response, market, since, limit)
    end

    def fetch_open_orders(symbol = nil, since = nil, limit = 10, params = {})
      if symbol.nil?
        raise(ExchangeError, self.id + 'fetchOpenOrders requires a symbol parameter')
      end
      self.load_markets
      market = self.market(symbol)
      request = {
        'currency' => market['id'],
        'pageIndex' => 1, # default pageIndex is 1
        'pageSize' => limit, # default pageSize is 10
      }
      method = 'privateGetGetUnfinishedOrdersIgnoreTradeType'
      # tradeType 交易类型1/0[buy/sell]
      if params.include?('tradeType')
        method = 'privateGetGetOrdersNew'
      end
      response = nil
      begin
        response = self.send_wrapper(method, self.class.shallow_extend(request, params))
      rescue BaseError => e
        if e.is_a?(OrderNotFound)
          return []
        end
        raise e
      end
      return self.parse_orders(response, market, since, limit)
    end

    def parse_order(order, market = nil)
      #
      # fetchOrder
      #
      #     {
      #         'total_amount' => 0.01,
      #         'id' => '20180910244276459',
      #         'price' => 180.0,
      #         'trade_date' => 1536576744960,
      #         'status' => 2,
      #         'trade_money' => '1.96742',
      #         'trade_amount' => 0.01,
      #         'type' => 0,
      #         'currency' => 'eth_usdt'
      #     }
      #
      side = (order['type'] == 1) ? 'buy' : 'sell'
      type = 'limit' # market order is not availalbe in ZB
      timestamp = nil
      createDateField = self.get_create_date_field
      if order.include?(createDateField)
        timestamp = order[createDateField]
      end
      symbol = nil
      if order.include?('currency')
        # get symbol from currency
        market = self.marketsById[order['currency']]
      end
      if market
        symbol = market['symbol']
      end
      price = order['price']
      filled = order['trade_amount']
      amount = order['total_amount']
      remaining = amount - filled
      cost = self.class.safe_float(order, 'trade_money')
      average = nil
      status = self.parse_order_status(self.class.safe_string(order, 'status'))
      if (cost != nil) && (filled != nil) && (filled > 0)
        average = cost / filled
      end
      result = {
        'info' => order,
        'id' => order['id'],
        'timestamp' => timestamp,
        'datetime' => self.class.iso8601(timestamp),
        'lastTradeTimestamp' => nil,
        'symbol' => symbol,
        'type' => type,
        'side' => side,
        'price' => price,
        'average' => average,
        'cost' => cost,
        'amount' => amount,
        'filled' => filled,
        'remaining' => remaining,
        'status' => status,
        'fee' => nil
      }
      return result
    end

    def parse_order_status(status)
      statuses = {
        '0' => 'open',
        '1' => 'canceled',
        '2' => 'closed',
        '3' => 'open', # partial
      }
      if statuses.include?(status)
        return statuses[status]
      end
      return status
    end

    def get_create_date_field
      return 'trade_date'
    end

    def nonce
      return self.class.milliseconds
    end

    def sign(path, api = 'public', method = 'GET', params = {}, headers = nil, body = nil)
      url = self.urls['api'][api]
      if api == 'public'
        url += '/' + self.version + '/' + path
        if params
          url += '?' + self.class.urlencode(params)
        end
      else
        query = self.class.keysort(self.class.shallow_extend({
          'method' => path,
          'accesskey' => self.apiKey
        }, params))
        nonce = self.nonce
        query = self.class.keysort(query)
        auth = self.class.rawencode(query)
        secret = self.class.hash(self.class.encode(self.secret), 'sha1')
        signature = self.class.hmac(self.class.encode(auth), self.class.encode(secret), 'md5')
        suffix = 'sign=' + signature + '&reqTime=' + nonce.to_s
        url += '/' + path + '?' + auth + '&' + suffix
      end
      return { 'url' => url, 'method' => method, 'body' => body, 'headers' => headers }
    end

    def handle_errors(httpCode, reason, url, method, headers, body, response)
      if !body.is_a?(String)
        return
      end # fallback to default error handler
      if body.length < 2
        return
      end # fallback to default error handler
      if body[0] == '{'
        feedback = self.id + ' ' + self.class.json(response)
        if response.include?('code')
          code = self.class.safe_string(response, 'code')
          if self.exceptions.include?(code)
            # ExceptionClass = self.exceptions[code]
            # raise(ExceptionClass, feedback)
            raise(self.exceptions[code], feedback)
          elsif code != '1000'
            raise(ExchangeError, feedback)
          end
        end
        # special case for {"result":false,"message":"服务端忙碌"}(a "Busy Server" reply)
        result = self.class.safe_value(response, 'result')
        if result != nil
          if !result
            message = self.class.safe_string(response, 'message')
            if message == '服务端忙碌'
              raise(ExchangeNotAvailable, feedback)
            else
              raise(ExchangeError, feedback)
            end
          end
        end
      end
    end
  end
end
