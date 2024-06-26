-- Account Database Schema:
CREATE TABLE IF NOT EXISTS account (
    id TEXT PRIMARY KEY UNIQUE DEFAULT (lower(hex(randomblob(4))) || '-' || lower(hex(randomblob(2))) || '-' || '4' || substr(lower(hex(randomblob(2))), 2) || '-' || substr('89ab',abs(random()) % 4 + 1, 1) || substr(lower(hex(randomblob(2))), 2) || '-' || lower(hex(randomblob(6)))),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    scheduled_timestamp DATETIME,
    data JSON,
    validated BOOLEAN DEFAULT FALSE
);

-- Order Database Schema:
CREATE TABLE IF NOT EXISTS orders (
    id TEXT PRIMARY KEY UNIQUE DEFAULT (lower(hex(randomblob(4))) || '-' || lower(hex(randomblob(2))) || '-' || '4' || substr(lower(hex(randomblob(2))), 2) || '-' || substr('89ab',abs(random()) % 4 + 1, 1) || substr(lower(hex(randomblob(2))), 2) || '-' || lower(hex(randomblob(6)))),
    oems_algorithm_id INTEGER,
    order_id TEXT,
    status TEXT,
    data JSON,
    validated BOOLEAN DEFAULT FALSE,
    created_at DATETIME,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Metrics Database Schema:
CREATE TABLE IF NOT EXISTS metrics (
    id TEXT PRIMARY KEY UNIQUE DEFAULT (lower(hex(randomblob(4))) || '-' || lower(hex(randomblob(2))) || '-' || '4' || substr(lower(hex(randomblob(2))), 2) || '-' || substr('89ab',abs(random()) % 4 + 1, 1) || substr(lower(hex(randomblob(2))), 2) || '-' || lower(hex(randomblob(6)))),
    exchange TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    scheduled_timestamp DATETIME,
    portfolio_account_metrics JSON,
    portfolio_return_metrics JSON,
    portfolio_risk_metrics JSON,
    portfolio_execution_quality_metrics JSON,
    position_execution_quality_metrics JSON,
    position_risk_metrics JSON,
    position_return_metrics JSON,
    timeframe TEXT
);

-- Account Data Insert Statements:
INSERT INTO account (
    id,
    created_at,
    scheduled_timestamp,
    data,
    validated
) VALUES (
    '1',
    '2023-01-01 00:00:00',
    '2023-01-01 00:00:00',
    '{"adjEq":"0.0","borrowFroz":"0.0","details":[{"ccy":"BTC","eq":"1.0","eqUsd":"30000","availBal":"0.0","availEq":"0.0","borrowFroz":"0.0","cashBal":"0.0","clSpotInUseAmt":"0.0","crossLiab":"0.0","disEq":"0.0","fixedBal":"0.0","frozenBal":"0.0","imr":"0.0","interest":"0.0","isoEq":"0.0","isoLiab":"0.0","isoUpl":"0.0","liab":"0.0","maxLoan":"0.0","mgnRatio":"0.0","mmr":"0.0","notionalLever":"0.0","ordFrozen":"0.0","rewardBal":"0.0","smtSyncEq":"0.0","spotInUseAmt":"0.0","spotIsoBal":"0.0","stgyEq":"0.0","twap":"0.0","uTime":null,"upl":"0.0","uplLiab":"0.0"},{"ccy":"USDT","eq":"100000","eqUsd":"100000","availBal":"0.0","availEq":"0.0","borrowFroz":"0.0","cashBal":"0.0","clSpotInUseAmt":"0.0","crossLiab":"0.0","disEq":"0.0","fixedBal":"0.0","frozenBal":"0.0","imr":"0.0","interest":"0.0","isoEq":"0.0","isoLiab":"0.0","isoUpl":"0.0","liab":"0.0","maxLoan":"0.0","mgnRatio":"0.0","mmr":"0.0","notionalLever":"0.0","ordFrozen":"0.0","rewardBal":"0.0","smtSyncEq":"0.0","spotInUseAmt":"0.0","spotIsoBal":"0.0","stgyEq":"0.0","twap":"0.0","uTime":null,"upl":"0.0","uplLiab":"0.0"}],"imr":"0.0","isoEq":"0.0","mgnRatio":"0.0","mmr":"0.0","notionalUsd":"0.0","ordFroz":"0.0","totalEq":"130000","uTime":"0","upl":"0.0"}'
    ,
    1
);

INSERT INTO account (
    id,
    created_at,
    scheduled_timestamp,
    data,
    validated
) VALUES (
    '2',
    '2023-01-02 00:00:00',
    '2023-01-02 00:00:00',
    '{"adjEq":"0.0","borrowFroz":"0.0","details":[{"ccy":"BTC","eq":"1.5","eqUsd":"45000","availBal":"0.0","availEq":"0.0","borrowFroz":"0.0","cashBal":"0.0","clSpotInUseAmt":"0.0","crossLiab":"0.0","disEq":"0.0","fixedBal":"0.0","frozenBal":"0.0","imr":"0.0","interest":"0.0","isoEq":"0.0","isoLiab":"0.0","isoUpl":"0.0","liab":"0.0","maxLoan":"0.0","mgnRatio":"0.0","mmr":"0.0","notionalLever":"0.0","ordFrozen":"0.0","rewardBal":"0.0","smtSyncEq":"0.0","spotInUseAmt":"0.0","spotIsoBal":"0.0","stgyEq":"0.0","twap":"0.0","uTime":null,"upl":"0.0","uplLiab":"0.0"},{"ccy":"USDT","eq":"80000","eqUsd":"80000","availBal":"0.0","availEq":"0.0","borrowFroz":"0.0","cashBal":"0.0","clSpotInUseAmt":"0.0","crossLiab":"0.0","disEq":"0.0","fixedBal":"0.0","frozenBal":"0.0","imr":"0.0","interest":"0.0","isoEq":"0.0","isoLiab":"0.0","isoUpl":"0.0","liab":"0.0","maxLoan":"0.0","mgnRatio":"0.0","mmr":"0.0","notionalLever":"0.0","ordFrozen":"0.0","rewardBal":"0.0","smtSyncEq":"0.0","spotInUseAmt":"0.0","spotIsoBal":"0.0","stgyEq":"0.0","twap":"0.0","uTime":null,"upl":"0.0","uplLiab":"0.0"}],"imr":"0.0","isoEq":"0.0","mgnRatio":"0.0","mmr":"0.0","notionalUsd":"0.0","ordFroz":"0.0","totalEq":"125000","uTime":"0","upl":"0.0"}'
    ,
    1
);

INSERT INTO orders (
    id,
    oems_algorithm_id,
    order_id,
    status,
    data,
    validated,
    created_at,
    updated_at
) VALUES (
    'a37eda33-405e-4e89-8705-86bdfbf564ec',
    0,
    '1556935276122767360',
    'filled',
    '{"live": {"instType": "SPOT", "instId": "MATIC-USDT", "tgtCcy": "", "ccy": "", "ordId": "1556935276122767360", "clOrdId": "17189026861", "algoClOrdId": "", "algoId": "", "tag": "", "px": "0.576", "sz": "1", "notionalUsd": "0.57580992", "ordType": "limit", "side": "buy", "posSide": "", "tdMode": "cash", "accFillSz": "0", "fillNotionalUsd": "", "avgPx": "0", "state": "live", "lever": "0", "pnl": "0", "feeCcy": "MATIC", "fee": "0", "rebateCcy": "USDT", "rebate": "0", "category": "normal", "uTime": "1718902687035", "cTime": "1718902687035", "source": "", "reduceOnly": "false", "cancelSource": "", "quickMgnType": "", "stpId": "", "stpMode": "cancel_maker", "attachAlgoClOrdId": "", "lastPx": "0.5747", "isTpLimit": "false", "slTriggerPx": "", "slTriggerPxType": "", "tpOrdPx": "", "tpTriggerPx": "", "tpTriggerPxType": "", "slOrdPx": "", "fillPx": "", "tradeId": "", "fillSz": "0", "fillTime": "", "fillPnl": "0", "fillFee": "0", "fillFeeCcy": "", "execType": "", "fillPxVol": "", "fillPxUsd": "", "fillMarkVol": "", "fillFwdPx": "", "fillMarkPx": "", "amendSource": "", "reqId": "", "amendResult": "", "code": "0", "msg": "", "pxType": "", "pxUsd": "", "pxVol": "", "linkedAlgoOrd": {"algoId": ""}, "attachAlgoOrds": []}, "filled": {"instType": "SPOT", "instId": "MATIC-USDT", "tgtCcy": "", "ccy": "", "ordId": "1556935276122767360", "clOrdId": "17189026861", "algoClOrdId": "", "algoId": "", "tag": "", "px": "0.576", "sz": "1", "notionalUsd": "0.57580992", "ordType": "limit", "side": "buy", "posSide": "", "tdMode": "cash", "accFillSz": "1", "fillNotionalUsd": "0.574310415", "avgPx": "0.5745", "state": "filled", "lever": "0", "pnl": "0", "feeCcy": "MATIC", "fee": "-0.001", "rebateCcy": "USDT", "rebate": "0", "category": "normal", "uTime": "1718902687036", "cTime": "1718902687035", "source": "", "reduceOnly": "false", "cancelSource": "", "quickMgnType": "", "stpId": "", "stpMode": "cancel_maker", "attachAlgoClOrdId": "", "lastPx": "0.5747", "isTpLimit": "false", "slTriggerPx": "", "slTriggerPxType": "", "tpOrdPx": "", "tpTriggerPx": "", "tpTriggerPxType": "", "slOrdPx": "", "fillPx": "0.5745", "tradeId": "6176408", "fillSz": "1", "fillTime": "1718902687035", "fillPnl": "0", "fillFee": "-0.001", "fillFeeCcy": "MATIC", "execType": "T", "fillPxVol": "", "fillPxUsd": "", "fillMarkVol": "", "fillFwdPx": "", "fillMarkPx": "", "amendSource": "", "reqId": "", "amendResult": "", "code": "0", "msg": "", "pxType": "", "pxUsd": "", "pxVol": "", "linkedAlgoOrd": {"algoId": ""}, "attachAlgoOrds": []}}'
    ,
    0,
    '2023-01-01 00:00:00',
    '2023-01-01 00:00:00'
);

INSERT INTO metrics (
    id,
    exchange,
    created_at,
    scheduled_timestamp,
    portfolio_account_metrics,
    portfolio_return_metrics,
    portfolio_risk_metrics,
    portfolio_execution_quality_metrics,
    position_execution_quality_metrics,
    position_risk_metrics,
    position_return_metrics,
    timeframe
) VALUES (
    '1e7d8b10-88a4-4e9d-bc0c-9a5d29bc66c8',
    'OK',
    '2023-06-01 12:00:00',
    '2023-12-01 12:00:00',
    '{"net_asset_value": 150000.00, "assets": 140000.00, "cash": 10000.00, "margin": 5000.00, "buying_power": 20000.00, "margin_utilization": 25.00, "margin_available": 15000.00, "volume": 0, "turnover": 0, "number_of_trades": 0}'
    ,
    '{"unrealized_pnl": 5000.00, "realized_pnl": 2000.00, "avg_pnl_per_trade": 100.00, "avg_positive_pnl": 150.00, "avg_negative_pnl": -50.00, "fees": 300.00, "cagr": 10.00, "win_rate": 60.00, "up_time": 70.00, "down_time": 30.00, "total_trades": 20, "long_trades": 15, "short_trades": 5}'
    ,
    '{"concentration": 30.00, "value_at_risk": 10000.00, "volatility": 5.00, "standard_deviation": 4.50, "beta": 1.20, "sharpe": 1.50, "max_drawdown": 20.00, "drawdown_period": 30, "drawdown_recovery": 20, "max_runup": 25.00, "runup_period": 15}'
    ,
    '{"unrealized_pnl": 3000.00, "realized_pnl": 1000.00, "fees": 150.00}',
    NULL,
    '{"concentration": 20.00, "value_at_risk": 5000.00, "sharpe_ratio": 1.30, "beta": 0.90, "volatility": 4.00, "standard_deviation": 4.00, "max_drawdown": 15.00, "drawdown_period": 20, "drawdown_recovery": 10, "max_runup": 18.00, "runup_period": 12}'
    ,
    NULL,
    '2023-06-01 to 2023-12-01'
);

INSERT INTO metrics (
    id,
    exchange,
    created_at,
    scheduled_timestamp,
    portfolio_account_metrics,
    portfolio_return_metrics,
    portfolio_risk_metrics,
    portfolio_execution_quality_metrics,
    position_execution_quality_metrics,
    position_risk_metrics,
    position_return_metrics,
    timeframe
) VALUES (
    '2e9d8b12-77a4-4e1d-bc0c-7a5d29bc66c8',
    'BINANCE',
    '2023-06-15 12:00:00',
    '2023-12-15 12:00:00',
    '{"net_asset_value": 250000.00, "assets": 230000.00, "cash": 20000.00, "margin": 10000.00, "buying_power": 30000.00, "margin_utilization": 33.33, "margin_available": 20000.00, "volume": 0, "turnover": 0, "number_of_trades": 0}'
    ,
    '{"unrealized_pnl": 7000.00, "realized_pnl": 3000.00, "avg_pnl_per_trade": 150.00, "avg_positive_pnl": 200.00, "avg_negative_pnl": -60.00, "fees": 400.00, "cagr": 12.00, "win_rate": 65.00, "up_time": 75.00, "down_time": 25.00, "total_trades": 25, "long_trades": 20, "short_trades": 5}'
    ,
    '{"concentration": 25.00, "value_at_risk": 15000.00, "volatility": 6.00, "standard_deviation": 5.00, "beta": 1.30, "sharpe": 1.70, "max_drawdown": 18.00, "drawdown_period": 28, "drawdown_recovery": 18, "max_runup": 30.00, "runup_period": 20}'
    ,
    '{"unrealized_pnl": 4000.00, "realized_pnl": 2000.00, "fees": 200.00}',
    NULL,
    '{"concentration": 22.00, "value_at_risk": 7000.00, "sharpe_ratio": 1.50, "beta": 1.10, "volatility": 5.50, "standard_deviation": 5.50, "max_drawdown": 17.00, "drawdown_period": 25, "drawdown_recovery": 15, "max_runup": 22.00, "runup_period": 16}'
    ,
    NULL,
    '2023-06-15 to 2023-12-15'
);