# You can't prove what your AI agent did. Now you can.

> The verifiable-cognition announcement. ~700 words. Publish on a blog /
> dev.to / HN / X thread. Facts accurate as of korgex v0.6.0 (2026-05-29).

Your coding agent just edited 40 files, ran 350 commands, and rewrote a
migration. Do you trust that the log it showed you is *complete and
unaltered*? You can't check. Every agent's session log — Claude Code,
Cursor, Codex — is an opaque, editable file. If something got dropped,
reordered, or quietly changed after the fact, you'd never know.

That's the gap **Korg** closes. Not "agent memory" (everyone has that now).
**Verifiable cognition**: every action an agent takes becomes a hash-chained,
tamper-evident ledger event you can cryptographically prove was never altered.

## The one-line difference

```
$ korgex audit
  audited session → 2,693 ledger events
  activity: llm_inference×1799, Bash×355, Edit×243, Read×100, Write×58
  chain:    ✓ INTACT — tamper-evident, cryptographically verifiable
```

That ran against Claude Code logs you **already have** — no setup, no buy-in.
Edit one byte of that journal and `korgex verify` tells you the exact event
that broke. With an HMAC key, the chain is tamper-*proof*, not just
tamper-evident.

## Why this isn't marketing

A "standard" with one implementation is a vendor's internal detail. So we built
**`korg-ledger@v1`** — a frozen, open spec with golden conformance vectors — and
**four independent implementations that reproduce the same hashes byte-for-byte**:

- the **Rust core** (`korg-registry`) chains every event on append,
- **korgex** (Python) verifies agent journals,
- **thumper** (Rust) chains every self-healing recovery loop,
- and a **JavaScript implementation that runs in your browser**.

Don't take our word for it — **[tamper a real ledger yourself](https://yvaehkorg.lol/ledger-explorer.html)**.
The page recomputes the chain in your browser with the same canonicalization as
the Rust and Python implementations; click "tamper" on any event and watch the
proof break, live.

## The substrate, not another app

Verifiable cognition is only useful if it's *reachable*. So korg is now an **MCP
server** — mount it in Claude Desktop, Cursor, or any MCP host:

```json
{ "mcpServers": { "korg-ledger": { "command": "korgex", "args": ["mcp-server"] } } }
```

Three tools any agent can call:

- **`korg_verify`** — prove a journal wasn't altered;
- **`korg_audit`** — audit the host agent's own logs, zero-config;
- **`korg_import`** — pull any vendor's session into a verifiable ledger.

That last one is the wedge competitors structurally can't ship: their memory is
their lock-in. korg sits *under* all of them as a neutral audit substrate — a
Claude Code, Codex, or Grok session, replayed into one inspectable, verifiable
artifact you own.

## Why it matters now

Agents are being handed write access to real systems — your repo, your infra,
your data. "Trust me, here's a log" doesn't survive contact with compliance,
incident review, or a teammate asking *what exactly did it change*. The MCP
ecosystem's own 2026 roadmap names governance as the gap. A tamper-evident,
cross-vendor, locally-owned cognition ledger — with an open spec and a tool any
agent can call — is the missing primitive.

## Try it in 30 seconds

```bash
pip install https://github.com/New1Direction/korgex/releases/download/v0.6.0/korgex-0.6.0-py3-none-any.whl
korgex audit          # verify the agent sessions you already have
korgex verify <journal>   # re-check any time — exit 0 if intact, 1 if tampered
```

Open source. Local. Yours. **[github.com/New1Direction/korg](https://github.com/New1Direction/korg)** ·
spec: `korg/spec/korg-ledger-v1/` · live demo: **[yvaehkorg.lol](https://yvaehkorg.lol)**

*Stop trusting your agent's log. Start verifying it.*
