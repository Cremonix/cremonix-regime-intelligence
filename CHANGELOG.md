# Changelog

All notable changes to Cremonix Signals will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-03-04

### Added
- Initial release of Cremonix Signals for OpenClaw
- Free tier with 4-hour delayed signals
- Paid tier with real-time signals ($25/month)
- Support for both Lightning and card payments
- BTC/ETH regime detection (1h and 4h timeframes)
- ML-powered entry signals from 36-model ensemble
- Agent discovery via JSON metadata in free feed
- Autonomous agent subscription flow
- Human web UI for subscription management
- OpenClaw auto-configuration support
- API key authentication for paid tier
- Wrapper script for auto-tier detection
- Example scripts (basic usage, pre-trade filter, agent subscribe)
- Comprehensive documentation (SKILL.md, README.md)

### Known Issues
- Signal availability depends on trading system state (will be resolved in v1.1 with global trigger log)
- Paid tier signals update every 30-60 seconds (best-effort based on system activity)

### Security
- API keys encrypted at rest (SHA-256 hashed)
- Email encryption for subscriber data
- HTTPS-only transmission
- No sensitive data in examples or documentation

---

## [Unreleased]

### Planned for v1.1.0
- Global trigger log for consistent signal delivery
- Independent signal generation from trading system state
- Improved paid tier reliability
- Faster signal updates (target: <10 seconds)

### Planned for v1.2.0
- Display all active combos (not just featured) for paid tier
- Model confidence breakdown (per-model agreement)
- Historical signal data endpoint
- WebSocket support for push-based real-time updates
- Additional timeframes (15m, 1d)

### Planned for v2.0.0
- Multi-asset support (SOL, MATIC, AVAX)
- Custom signal combos (user-defined model weights)
- Alert webhooks (Discord, Telegram, Slack)
- Portfolio sync (track positions vs signals)
- Backtesting API (test historical performance)

---

## Version History

- **1.0.0** (2026-03-04) - Initial public release
