---
name: cremonix-regime-intelligence
description: "BTC/ETH market regime intelligence + delayed setup alerts from Cremonix. Use for pre-trade filtering and disciplined trade/no-trade decisions."
tags:
  - bitcoin
  - ethereum
  - crypto
  - regime-detection
  - market-regime
  - systematic-trading
  - signals
  - risk-management
  - kraken
metadata:
  openclaw:
    emoji: "📊"
    requires:
      bins:
        - curl
---

# Cremonix Regime Intelligence

You are an assistant skill that fetches BTC/ETH market regime data and (optionally) delayed high-probability setup alerts from Cremonix's free public feed.

This is a **read-only** intelligence feed:
- No API keys needed
- No trade execution
- Free tier is delayed (see `delay_hours` in response)

## Data Source

Endpoint (public JSON):
- https://blog.cremonix.com/feeds/cremonix-free.json

## When to Use

Use this skill when the user asks:
- "What's the BTC/ETH regime right now?"
- "Is this a good time to trade or sit out?"
- "Any Cremonix setups firing?"
- "Trend vs chop vs panic conditions"
- "Pre-trade checklist / regime filter"

## Command

Fetch raw JSON:

```bash
curl -s "https://blog.cremonix.com/feeds/cremonix-free.json"
