# Durable decisions

## Confirmed decisions
1. **Identity is GAL Labs / GAL Method (Guide · Align · Lead).** Reason: represent the established method and product accurately without replacing internal technical identifiers. Source: [product overview](../PRODUCT.md), reviewed on 2026-10-11.
2. **GAL Core defines semantics; host adapters map execution mechanics.** Reason: preserve provider and host independence. Sources: [architecture](../ARCHITECTURE.md) and [Host Adapter Contract](../../runtime/contracts/HOST-ADAPTER-CONTRACT.md).
3. **Canonical GAL project state is JSON; context views are generated.** Reason: avoid competing mutable sources of truth. Sources: [architecture](../ARCHITECTURE.md), [runtime rules](../../runtime/README.md), and [GAL Core](../../runtime/steering/gal-core.md). The files under this directory are contributor orientation, not a replacement state store.
4. **Validation truth and content readiness remain distinct.** Reason: useful stakeholder review may proceed without fabricating deterministic validation, while development and QA retain their documented gates. Sources: [GAL Core](../../runtime/steering/gal-core.md) and [development history](../CHANGELOG.md).
5. **Runtime and public packages exclude test oracles and blind-run results.** Reason: preserve meaningful conformance and the user deliverable boundary. Sources: [public-package policy](../PUBLIC-PACKAGE.md) and [testing rules](../TESTING.md).
6. **Public visibility does not grant an open-source license.** Reason: distribution rights are governed by the existing license. Source: [LICENSE](../../LICENSE).

## Open decisions
- First public distribution/license channel, support contact, terms, and download/release convention remain open in [launch readiness](../LAUNCH-READINESS.md).
- Planned host integrations and their observed conformance remain milestone work in [roadmap](../ROADMAP.md); generic context loaders do not settle those engineering gates.

## Recording rules
Record confirmed durable choices with date, reason, authority, and a source link. Keep proposals and unresolved choices open. Preserve historical records and link underlying architecture, contract, or release documents instead of duplicating them. Do not commit secrets, customer data, or private project evidence. Do not use this file to change GAL canonical state or Core semantics.
