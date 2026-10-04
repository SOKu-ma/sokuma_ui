# Changelog

## 0.2.0 - 2026-10-05

4 アプリ（打率ノート / サッカーラインナップ / 野球オーダー表 / ダーツログ）で
重複していた配色・余白・部品を集約。

### 破壊的変更

- `AppSpacing` の段を実使用に合わせて変更（12 / 20 を追加）。
  旧 `md 16 / lg 24 / xl 32` は新 `lg / xxl / xxxl` に読み替える
- `AppRadius` の段を変更。旧 `sm 4 / md 8` は新 `xs / sm` に読み替える
- `AppTextStyles.headline` / `title` を一段太く（w800 / w700）

### 追加

- トークン: `AppGrays`（iOS システムグレー）、`AppColors.premiumGold*`、
  `AppSpacing.xxs / xxl / xxxl`、`AppRadius.xs / xl / sheetTop`、
  `AppTextStyles.subtitle / numeric`
- テーマ: `AppColorSchemes.monochrome` / `seeded`、`buildAppTheme(colorScheme:, scaffoldBackgroundColor:)`。
  ボタン・入力欄・カード・ダイアログ・シート・スナックバー・ナビゲーションバー等の部品テーマ
- 部品: `AppSegmentedControl`、`AppSectionHeader`、`AppPanel`、`AppEmptyState`、
  `AppPill`、`AppSettingsSection` / `AppSettingsTile`、`AppMetricTile`、
  `AppSheetHandle` / `showAppBottomSheet`、`showAppConfirmDialog`、`AppSnackBar`、
  `AppLoadingOverlay`
- example を全部品のカタログに更新

### 修正

- `AppChoiceChip`: 無効状態で選択中のときにプライマリで塗らず、無効色で表示するよう修正
- `AppChoiceChip`: ライト / ダーク両テーマでの塗り・枠線をテストで担保
- example: ダークテーマと themeMode 切り替えを追加
- example を GitHub Pages で公開（https://www.so-kuma.com/sokuma_ui/）

## 0.1.0 - 2026-10-02

- 初回リリース
- トークン: `AppColors` / `AppSpacing` / `AppRadius` / `AppTextStyles`
- テーマ: `buildAppTheme(seedColor:)`
- 部品: `AppChoiceChip`（選択時はプライマリで塗りつぶし、チェックマークなし）
