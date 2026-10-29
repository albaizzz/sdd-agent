# SDD Agent — Specification-Driven Development Skill

Skill untuk **AI coding agent** (opencode, Claude Code, Codex, GitHub Copilot) yang menerapkan **Specification-Driven Development (SDD)**: *tidak ada kode yang menyentuh codebase sebelum sebuah spesifikasi teknis ditulis, direview, dan disetujui.*

## Cara Kerja (Lifecycle)

```
Foundation Gate → Requirements → 13-Point Spec → Review → Human Approval → Task Breakdown → Implementation → Verification → Done
```

| Fase | Fungsi | Output |
|------|--------|--------|
| 0. Foundation Gate | Cek 4 dokumen dasar proyek (PRD, DESIGN_SYSTEM, ARCHITECTURE, AGENTS). Kalau kurang, agent wawancara kamu dulu | 4 file foundation |
| 1. Requirements | Kumpulkan kebutuhan fitur | input contract |
| 2. Draft Spec | Agent menulis spec 13 poin | `docs/specs/<ticket-id>.md` |
| 3. Review | Agent jadi devil's advocate, kritik spec (max 3 ronde) | gap report |
| 4. Approval | **Manusia yang setujui** — bukan AI | spec approved |
| 4.5. Task Breakdown | Pecah spec jadi task kecil berurut + dependensi | `docs/tasks/<ticket-id>.md` |
| 5. Implementation | Agent eksekusi task satu per satu sesuai urutan | PR / diff |
| 6. Verification | Verifikasi terhadap Definition of Done (spec + per task) | hasil test |

> Prinsip inti: **AI memberi saran, manusia yang memutuskan.** Agent tidak pernah menyetujui/memblokir sendiri.

## Struktur Repo

```
sdd-agent/
├── .opencode/skills/sdd/           # skill (opencode) — frontmatter + workflow SDD
│   ├── SKILL.md
│   └── templates/
│       ├── PRD.md                  # template dokumen foundation
│       ├── DESIGN_SYSTEM.md
│       ├── ARCHITECTURE.md
│       ├── AGENTS.md               # coding SOP + SDD rules (diisi saat gate)
│       ├── SPEC.md                 # template spec 13 poin
│       └── TASKS.md                # template task breakdown
├── .claude/skills/sdd/             # skill (Claude Code) — copy dari .opencode
├── AGENTS.md                       # entry point Codex/Copilot/opencode (rules SDD)
├── CLAUDE.md                       # entry point Claude Code (rules SDD)
├── .github/copilot-instructions.md # entry point GitHub Copilot (rules SDD)
├── specs.md                        # referensi detail proses SDD (13 poin, fase A/B)
└── install-foundation.sh           # installer ke repo target
```

## Kompatibilitas Agent

Satu workflow, tiap tool memuat lewat mekanismenya sendiri:

| Tool | Entry point | Skill location |
|------|-------------|----------------|
| opencode | `AGENTS.md` + skill frontmatter | `.opencode/skills/sdd/SKILL.md` |
| Claude Code | `CLAUDE.md` + skill | `.claude/skills/sdd/SKILL.md` |
| Codex | `AGENTS.md` | `.opencode/skills/sdd/` (workflow sama) |
| GitHub Copilot | `.github/copilot-instructions.md` + `AGENTS.md` | `.opencode/skills/sdd/` (workflow sama) |

Aturan SDD selalu dibawa di `AGENTS.md` saat dokumen foundation dibuat — itu yang membuat gate dipatuhi agent mana pun.

## Cara Pakai

### 1. Install skill ke repo target

```bash
./install-foundation.sh /path/to/your/repo
```

Ini menyalin skill (`.opencode/skills/sdd/` + `.claude/skills/sdd/`) dan entry-point doc (AGENTS.md, CLAUDE.md, specs.md, `.github/copilot-instructions.md`) ke repo target. **Restart opencode / Claude Code** di repo target agar skill termuat.

> Catatan: Jika target sudah punya `AGENTS.md`/`CLAUDE.md` tapi tanpa aturan SDD, file lama di-overwrite — cek diff `git log` setelah install. Foundation docs (PRD/DESIGN_SYSTEM/ARCHITECTURE) tidak ikut disalin — skill membuatnya via wawancara.

### 2. Mulai fitur baru

**opencode / Claude Code** — buka di repo target (skill sudah ter-load otomatis), lalu minta seperti ini:

```
Buat fitur: <deskripsi fitur>. 
Affected area: <module/service/endpoint>. 
Priority: P1.
```

**Codex / GitHub Copilot** — tanpa skill, agent membaca aturan SDD dari `AGENTS.md` (root repo). Minta dengan format yang sama; agent harus mengikuti lifecycle SDD dari file itu. Untuk Copilot (Chat/Edit/Review) rujuk juga `.github/copilot-instructions.md`.

Skill akan otomatis (di tool apa pun):

1. **Gate check** — cek PRD/DESIGN_SYSTEM/ARCHITECTURE/AGENTS.
   - Kurang → ditanya dulu satu per satu (maks 3 ronde per file), baru dibuat.
   - Lengkap → lanjut.
2. **Draft spec** — tulis 13-poin spec ke `docs/specs/<ticket-id>.md`.
3. **Review** — kritik spec, minta kamu menutup gap (socratic).
4. **Tunggu approval kamu** — spec disetujui hanya setelah kamu konfirmasi.
5. **Task breakdown** — pecah spec jadi daftar task kecil: urutan, dependensi, file target, DoD per task, dikonfirmasi kamu dulu.
6. **Implementasi** — agent eksekusi task satu per satu sesuai urutan.
7. **Verifikasi** — jalankan test & cek Definition of Done per task.

### 3. Review spec yang sudah ada

```
Review draft spec ini dan tunjukkan gap-nya: <path>
```

### 4. Banding / tolak balik

Kalau agent salah menolak/menyetujui spec, kamu bisa **appeal** dengan alasan tertulis — manusia yang override.

## 13 Poin Spec

1. Business Requirement — kenapa fitur ini dibuat
2. Goals — metrik sukses
3. Out of Scope — batasan non-goals
4. Constraints — limitasi sistem/waktu/sumber daya
5. Definition of Done — kriteria selesai yang terukur (pass/fail)
6. Technical Solution — arsitektur, API contract, dependency baru
6a. Security & Compliance — authz/authn, PII, secrets
6b. Decision Record — alternatif yang ditolak & alasannya
7. Database Impact — skema, index, migration, downtime
8. Code Impact — file yang berubah, dengan `file:line`, blast radius
9. Testing & Regression — strategi agar fitur lama tidak rusak
10. Backward Compatibility & Rollback — trigger rollback, siapa memutuskan
11. Deployment & Migration — toggles, canary, observability

## Format Input yang Direkomendasikan

```
Feature description: <apa & kenapa dibangun>
Affected area (opsional): <modul/service/endpoint yang diduga terlibat>
Priority: <P0/P1/P2> + deadline
Existing draft spec (opsional): <path draft yang mau dikritik>
```

Jika deskripsi terlalu samar, agent akan bertanya maksimal **3 pertanyaan**, lalu lanjut dengan asumsi yang ditandai `assumed — verify`.

## Lokasi Artefak

- Spec: `docs/specs/<ticket-id>.md` (version-controlled, status ada di header file)
- Task list: `docs/tasks/<ticket-id>.md` (urutan eksekusi, dependensi, DoD per task)
- Lifecycle spec: `Draft → In Review → Approved → Task Breakdown → In Implementation → Deployed → Done`
- Deliverable fitur: spec + task list + PR (link ke ticket & spec) + hasil verifikasi

## Tips

- Beri info `file:line` di deskripsi fitur → agent lebih cepat & akurat.
- Setuju/ditolak spec **selalu dengan konfirmasi eksplisitmu** — jangan biarkan agent self-approve.
- File foundation yang sudah usang/konflik dengan codebase → flag ke developer, jangan diam-diam ditulis ulang.
- Track per ticket: time-to-spec, socratic rounds, rework rate, defect leak — untuk mengukur efektivitas SDD.