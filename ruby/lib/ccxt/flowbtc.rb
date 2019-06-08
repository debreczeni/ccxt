# -*- coding: utf-8 -*-
# frozen_string_literal: true

# PLEASE DO NOT EDIT THIS FILE, IT IS GENERATED AND WILL BE OVERWRITTEN:
# https://github.com/ccxt/ccxt/blob/master/CONTRIBUTING.md#how-to-contribute-code

module Ccxt
  class Flowbtc < Exchange
    def describe
      return self.deep_extend(super, {
        'id' => 'flowbtc',
        'name' => 'flowBTC',
        'countries' => ['BR'], # Brazil
        'version' => 'v1',
        'rateLimit' => 1000,
        'has' => {
          'CORS' => true
        },
        'urls' => {
          'logo' => 'https://user-images.githubusercontent.com/1294454/28162465-cd815d4c-67cf-11e7-8e57-438bea0523a2.jpg',
          'api' => 'https://api.flowbtc.com:8405/ajax',
          'www' => 'https://trader.flowbtc.com',
          'doc' => 'https://www.flowbtc.com.br/api.html'
        },
        'requiredCredentials' => {
          'apiKey' => true,
          'secret' => true,
          'uid' => true
        },
        'api' => {
          'public' => {
            'post' => [
              'GetTicker',
              'GetTrades',
              'GetTradesByDate',
              'GetOrderBook',
              'GetProductPairs',
              'GetProducts'
            ]
          },
          'private' => {
            'post' => [
              'CreateAccount',
              'GetUserInfo',
              'SetUserInfo',
              'GetAccountInfo',
              'GetAccountTrades',
              'GetDepositAddresses',
              'Withdraw',
              'CreateOrder',
              'ModifyOrder',
              'CancelOrder',
              'CancelAllOrders',
              'GetAccountOpenOrders',
              'GetOrderFee'
            ]
          }
        },
        'fees' => {
          'trading' => {
            'tierBased' => false,
            'percentage' => true,
            'maker' => 0.0035,
            'taker' => 0.0035
          }
        }
      })
    end

    def fetch_markets(params = {})
      response = self.publicPostGetProductPairs
      markets = response['productPairs']
      result = {}
      for p in (0...markets.length)
        market = markets[p]
        id = market['name']
        base = market['product1Label']
        quote = market['product2Label']
        precision = {
          'amount' => self.safe_integer(market, 'product1DecimalPlaces'),
          'price' => self.safe_integer(market, 'product2DecimalPlaces')
        }
        symbol = base + '/' + quote
        result[symbol] = {
          'id' => id,
          'symbol' => symbol,
          'base' => base,
          'quote' => quote,
          'precision' => precision,
          'limits' => {
            'amount' => {
              'min' => nil,
              'max' => nil
            },
            'price' => {
              'min' => nil,
              'max' => nil
            },
            'cost' => {
              'min' => nil,
              'max' => nil
            }
          },
          'info' => market
        }
      end
      return result
    end

    def fetch_balance(params = {})
      self.load_markets
      response = self.privatePostGetAccountInfo
      balances = response['currencies']
      result = { 'info' => response }
      for b in (0...balances.length)
        balance = balances[b]
        currency = balance['name']
        account = {
          'free' => balance['balance'],
          'used' => balance['hold'],
          'total' => 0.0
        }
        account['total'] = self.sum(account['free'], account['used'])
        result[currency] = account
      end
      return self.parse_balance(result)
    end

    def fetch_order_book(symbol, limit = nil, params = {})
      self.load_markets
      market = self.market(symbol)
      orderbook = self.publicPostGetOrderBook(self.shallow_extend({
        'productPair' => market['id']
      }, params))
      return self.parse_order_book(orderbook, nil, 'bids', 'asks', 'px', 'qty')
    end

    def fetch_ticker(symbol, params = {})
      self.load_markets
      market = self.market(symbol)
      ticker = self.publicPostGetTicker(self.shallow_extend({
        'productPair' => market['id']
      }, params))
      timestamp = self.milliseconds
      last = self.safe_float(ticker, 'last')
      return {
        'symbol' => symbol,
        'timestamp' => timestamp,
        'datetime' => self.iso8601(timestamp),
        'high' => self.safe_float(ticker, 'high'),
        'low' => self.safe_float(ticker, 'low'),
        'bid' => self.safe_float(ticker, 'bid'),
        'bidVolume' => nil,
        'ask' => self.safe_float(ticker, 'ask'),
        'askVolume' => nil,
        'vwap' => nil,
        'open' => nil,
        'close' => last,
        'last' => last,
        'previousClose' => nil,
        'change' => nil,
        'percentage' => nil,
        'average' => nil,
        'baseVolume' => self.safe_float(ticker, 'volume24hr'),
        'quoteVolume' => self.safe_float(ticker, 'volume24hrProduct2'),
        'info' => ticker
      }
    end

    def parse_trade(trade, market)
      timestamp = trade['unixtime'] * 1000
      side = (trade['incomingOrderSide'] == 0) ? 'buy' : 'sell'
      return {
        'info' => trade,
        'timestamp' => timestamp,
        'datetime' => self.iso8601(timestamp),
        'symbol' => market['symbol'],
        'id' => trade['tid'].to_s,
        'order' => nil,
        'type' => nil,
        'side' => side,
        'price' => trade['px'],
        'amount' => trade['qty']
      }
    end

    def fetch_trades(symbol, since = nil, limit = nil, params = {})
      self.load_markets
      market = self.market(symbol)
      response = self.publicPostGetTrades(self.shallow_extend({
        'ins' => market['id'],
        'startIndex' => -1
      }, params))
      return self.parse_trades(response['trades'], market, since, limit)
    end

    def create_order(symbol, type, side, amount, price = nil, params = {})
      self.load_markets
      orderType = (type == 'market') ? 1 : 0
      order = {
        'ins' => self.market_id(symbol),
        'side' => side,
        'orderType' => orderType,
        'qty' => amount,
        'px' => self.price_to_precision(symbol, price)
      }
      response = self.privatePostCreateOrder(self.shallow_extend(order, params))
      return {
        'info' => response,
        'id' => response['serverOrderId']
      }
    end

    def cancel_order(id, symbol = nil, params = {})
      self.load_markets
      if params.include?('ins')
        return self.privatePostCancelOrder(self.shallow_extend({
          'serverOrderId' => id
        }, params))
      end
      raise(ExchangeError, self.id + ' requires `ins` symbol parameter for cancelling an order')
    end

    def sign(path, api = 'public', method = 'GET', params = {}, headers = nil, body = nil)
      url = self.urls['api'] + '/' + self.version + '/' + path
      if api == 'public'
        if params
          body = self.json(params)
        end
      else
        self.check_required_credentials
        nonce = self.nonce
        auth = nonce.to_s + self.uid + self.apiKey
        signature = self.hmac(self.encode(auth), self.encode(self.secret))
        body = self.json(self.shallow_extend({
          'apiKey' => self.apiKey,
          'apiNonce' => nonce,
          'apiSig' => signature.upcase
        }, params))
        headers = {
          'Content-Type' => 'application/json'
        }
      end
      return { 'url' => url, 'method' => method, 'body' => body, 'headers' => headers }
    end

    def request(path, api = 'public', method = 'GET', params = {}, headers = nil, body = nil)
      response = self.fetch2(path, api, method, params, headers, body)
      if response.include?('isAccepted')
        if response['isAccepted']
          return response
        end
      end
      raise(ExchangeError, self.id + ' ' + self.json(response))
    end
  end
end
