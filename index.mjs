const FEED_URL = "https://blog.cremonix.com/feeds/cremonix-free.json";

// ---- Helpers ----
async function fetchJson(url, { timeoutMs = 8000 } = {}) {
  const controller = new AbortController();
  const t = setTimeout(() => controller.abort(), timeoutMs);

  try {
    const res = await fetch(url, {
      method: "GET",
      headers: {
        accept: "application/json",
        "user-agent": "openclaw-skill/cremonix-free-feed",
      },
      signal: controller.signal,
    });

    if (!res.ok) {
      const text = await res.text().catch(() => "");
      throw new Error(`HTTP ${res.status} fetching feed. Body: ${text.slice(0, 200)}`);
    }

    return await res.json();
  } finally {
    clearTimeout(t);
  }
}

function safeStr(v, fallback = "UNKNOWN") {
  if (v === null || v === undefined || v === "") return fallback;
  return String(v);
}

function pickFirstSetup(payload) {
  const candidates = [
    { symbol: "BTC", asset: payload?.btc },
    { symbol: "ETH", asset: payload?.eth },
  ];
  for (const c of candidates) {
    if (c?.asset?.setup?.exists) return c;
  }
  return null;
}

function formatSummary(payload) {
  const btcR1 = safeStr(payload?.btc?.regime_1h);
  const btcR4 = safeStr(payload?.btc?.regime_4h);
  const ethR1 = safeStr(payload?.eth?.regime_1h);
  const ethR4 = safeStr(payload?.eth?.regime_4h);

  const ctaUrl = payload?.cta?.url || "https://cremonix.com";
  const setupCandidate = pickFirstSetup(payload);

  if (setupCandidate) {
    const { symbol, asset } = setupCandidate;
    const setup = asset?.setup || {};

    const comboId =
      setup?.combo_id ??
      setup?.comboId ??
      setup?.id ??
      setup?.name ??
      `${symbol}_UNKNOWN_COMBO`;

    const triggeredAt =
      setup?.triggered_at ??
      setup?.triggeredAt ??
      setup?.ts ??
      setup?.time ??
      payload?.triggered_at ??
      payload?.triggeredAt ??
      payload?.generated_at ??
      "UNKNOWN";

    const regimeAtTrigger = safeStr(asset?.regime_4h ?? asset?.regime_1h);

    return [
      `BTC Regime (1h): ${btcR1}`,
      `BTC Regime (4h): ${btcR4}`,
      `ETH Regime (1h): ${ethR1}`,
      `ETH Regime (4h): ${ethR4}`,
      ``,
      `⚡ A high-probability setup fired at ${safeStr(triggeredAt)} (shown with a 4-hour delay) for ${safeStr(comboId)} during ${regimeAtTrigger} regime.`,
      ``,
      `Cremonix runs 36 ML models 24/7 and executes automatically on Kraken.`,
      `Funds never leave your exchange. → ${ctaUrl.replace(/\/$/, "")}`,
    ].join("\n");
  }

  return [
    `BTC Regime (1h): ${btcR1}`,
    `BTC Regime (4h): ${btcR4}`,
    `ETH Regime (1h): ${ethR1}`,
    `ETH Regime (4h): ${ethR4}`,
    ``,
    `No high probability setup currently. Cremonix blocked trading`,
    `in this regime — knowing when NOT to trade is the edge.`,
    ``,
    `Cremonix automates BTC & ETH trading on Kraken.`,
    `Connect your API, it handles the rest. → ${ctaUrl.replace(/\/$/, "")}`,
  ].join("\n");
}

// ✅ Export an object (most compatible)
export default {
  tools: {
    cremonix_free_feed: async () => {
      return await fetchJson(FEED_URL);
    },
    cremonix_summary: async () => {
      const payload = await fetchJson(FEED_URL);
      return formatSummary(payload);
    },
  },
};
