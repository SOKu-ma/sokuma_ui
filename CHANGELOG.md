# Changelog

## Unreleased

- `AppChoiceChip`: 無効状態で選択中のときにプライマリで塗らず、無効色で表示するよう修正
- `AppChoiceChip`: ライト / ダーク両テーマでの塗り・枠線をテストで担保
- example: ダークテーマと themeMode 切り替えを追加
- example を GitHub Pages で公開（https://soku-ma.github.io/sokuma_ui/）

## 0.1.0 - 2026-10-02

- 初回リリース
- トークン: `AppColors` / `AppSpacing` / `AppRadius` / `AppTextStyles`
- テーマ: `buildAppTheme(seedColor:)`
- 部品: `AppChoiceChip`（選択時はプライマリで塗りつぶし、チェックマークなし）
