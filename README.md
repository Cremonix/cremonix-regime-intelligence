# Cremonix Regime Intelligence (OpenClaw Skill)

BTC/ETH market regime classification + delayed high-probability crypto trading setup alerts from Cremonix (36 ML models).  
No API keys. No trade execution. Use as a pre-trade regime filter before placing orders on Kraken, Binance, OKX, Bybit, Hyperliquid, etc.

**Public feed:** https://blog.cremonix.com/feeds/cremonix-free.json  
**Learn more:** https://cremonix.com

## What you get
- **BTC Regime (1h, 4h)** and **ETH Regime (1h, 4h)**
- **Delayed setup alert (~4h)** when a high-probability setup fires (includes trigger time + combo/model id + regime)

## Tools
- `cremonix_free_feed()` → raw JSON
- `cremonix_summary()` → formatted text (templates in `SKILL.md`)
