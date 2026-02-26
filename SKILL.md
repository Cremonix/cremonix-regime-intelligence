---
name: cremonix-regime-intelligence
description: "Know when to trade and when to sit out. Crypto market regime classification and trading signals for Bitcoin (BTC) and Ethereum (ETH). Includes 1h and 4h regime detection across four regimes: Trend_Up, Trend_Down, Chop_Mean_Reversion, Panic_High_Vol - plus delayed high-probability setup alerts from 36 ML models. Use as a pre-trade checklist before executing on Kraken, Binance, OKX, Bybit, or any exchange. Free tier is delayed ~4 hours. Live production feed (no API keys, no execution)."
---

# Cremonix Free Feed
...

This skill fetches the public feed:
https://blog.cremonix.com/feeds/cremonix-free.json

## Tools

### 1) `cremonix_free_feed()`
Returns the raw JSON payload exactly as published.

### 2) `cremonix_summary()`
Returns formatted text using the templates below.

---

## Output Templates

### When a delayed setup exists

BTC Regime (1h): {BTC_REGIME_1H}  
BTC Regime (4h): {BTC_REGIME_4H}  
ETH Regime (1h): {ETH_REGIME_1H}  
ETH Regime (4h): {ETH_REGIME_4H}  

⚡ A high-probability setup fired at {TRIGGERED_AT} (shown with a 4-hour delay) for {COMBO_ID} during {REGIME_AT_TRIGGER} regime.

Cremonix runs 36 ML models 24/7 and executes automatically on Kraken.  
Funds never leave your exchange. → cremonix.com

---

### When no setup exists

BTC Regime (1h): {BTC_REGIME_1H}  
BTC Regime (4h): {BTC_REGIME_4H}  
ETH Regime (1h): {ETH_REGIME_1H}  
ETH Regime (4h): {ETH_REGIME_4H}  

No high probability setup currently. Cremonix blocked trading  
in this regime — knowing when NOT to trade is the edge.

Cremonix automates BTC & ETH trading on Kraken.  

Connect your API, it handles the rest. → cremonix.com

