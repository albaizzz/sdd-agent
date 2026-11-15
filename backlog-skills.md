# Backlog: SDD Skill untuk Human Spec Writer

Checklist hasil analisis gap. Fokus: human yang kuat di spesifikasi, AI sebagai pembimbing dan reviewer.

## A. Gap untuk human penulis spec

- [ ] Panduan menulis spec (contoh bagus vs buruk, checklist kualitas) — sebagian: quality bar per section ada, contoh bagus vs buruk belum
- [x] ID requirement stabil: FR-xxx, NFR-xxx, AC-xxx
- [x] Format acceptance criteria: Given/When/Then atau EARS (Given/When/Then saja, EARS belum)
- [x] Deteksi ambiguitas (kata seperti "cepat", "aman", "sesuai" tanpa angka)
- [ ] Section edge case, failure mode, state transition, aturan validasi, permission matrix — sebagian: error status table dan cek empty state ada, state transition dan permission matrix belum
- [x] NFR wajib berangka (p95, throughput, availability)
- [x] Register Open Questions dan Assumptions (owner, deadline)
- [ ] Glossary istilah domain
- [ ] Tipe spec selain feature: bugfix, refactor, spike — sebagian: field Type sudah ada, panduan per tipe belum
- [ ] Proses amandemen setelah Approved (change request, versioning)
- [ ] Mode spec-only untuk brownfield, tanpa interview foundation penuh

## B. Gap enforcement dan infrastruktur

- [ ] PR template yang mewajibkan link spec dengan status Approved
- [ ] CI check: spec Approved sebelum merge
- [ ] CODEOWNERS untuk `docs/specs/`
- [ ] Validator spec: 13 section, status header, placeholder `<...>` tersisa, format `file:line`
- [ ] Definisikan format ticket-id dan buat `docs/specs/`, `docs/tasks/`
- [ ] Satu sumber rules: kurangi duplikasi antara `.opencode/`, `.claude/`, AGENTS.md, CLAUDE.md, copilot-instructions.md, specs.md, README.md
- [ ] Sinkronisasi skill `.opencode/` dan `.claude/` (symlink atau script)
- [ ] Tempat pencatatan metrik SDD (time-to-spec, socratic rounds, rework rate, defect leak)

## C. Inkonsistensi yang perlu diperbaiki

- [ ] `specs.md:62`: lifecycle belum memuat `Task Breakdown` (SKILL.md:167, README.md:135, AGENTS.md:27 sudah memuatnya)
- [ ] `AGENTS.md:36-39` dan `CLAUDE.md:32-35`: Coding SOP masih `<fill>`
- [ ] PRD.md, DESIGN_SYSTEM.md, ARCHITECTURE.md belum ada di repo, sehingga gate repo ini akan BLOCK

## D. Skill yang perlu dibuat

- [x] **spec-writer**: membimbing human section demi section lewat pertanyaan, tidak menulis ganti (ID FR/NFR/AC, Open Questions, Assumptions sudah masuk template)
- [ ] **spec-quality-review**: rubric, deteksi smell ambiguitas, validator
- [ ] **requirements-elicitation**: bank pertanyaan per domain (edge case, error, permission, data) dan format EARS/Given-When-Then
- [ ] **spec-traceability**: matriks FR → task → test → `file:line`
- [ ] **codebase-impact**: verifikasi caller dan blast radius dengan grep atau LSP
- [ ] **spec-change-control**: amandemen setelah Approved
- [x] **foundation-gate**: dipisah dari `sdd`, Phase 0 di `sdd` sekarang merujuk ke skill ini (mode spec-only belum)

## E. Urutan prioritas

- [ ] P1: tambah ID requirement, format AC, dan Open Questions ke template
- [ ] P2: validator dan PR template sebagai gate
- [ ] P3: skill spec-writer dan spec-quality-review
- [ ] P4: perbaiki inkonsistensi bagian C
