# sokuma_ui

個人開発している複数の Flutter アプリで、見た目と操作感をそろえるためのデザインシステムです。

## このパッケージについて

- **自分のアプリ用に育てているもの**です。汎用 UI ライブラリを目指してはおらず、
  部品は実際のアプリで必要になったものだけを追加します。
- **破壊的変更がありえます。** バージョンが 1.0 未満のあいだは、マイナーバージョンでも
  API が変わることがあります。利用する側では `ref` でタグを固定してください。
- pub.dev には公開していません。git 依存で利用します。

## 含まれるもの

野球打率ノート / サッカーラインナップ / 野球オーダー表 / ダーツログで重複していた
配色・余白・部品を集約したものです。

### トークン

| 名前 | 内容 |
| --- | --- |
| `SkColors` | 既定シード色、success / warning / error、プレミアム用ゴールド |
| `SkGrays` | iOS システムグレー（gray6〜gray / darkGray6〜darkGray2）と ink |
| `SkSpacing` | 余白 xxs 2 / xs 4 / sm 8 / md 12 / lg 16 / xl 20 / xxl 24 / xxxl 32 |
| `SkRadius` | 角丸 xs 4 / sm 8 / md 12 / lg 16 / xl 20 / full、`sheetTop` |
| `SkTextStyles` | headline / title / subtitle / body / label / caption / numeric（等幅数字） |

### テーマ

| 名前 | 内容 |
| --- | --- |
| `buildSkTheme(colorScheme: / seedColor:)` | ボタン・入力欄・カード・ダイアログ・シート・スナックバー等の形と余白をそろえた ThemeData |
| `SkColorSchemes.monochrome(brightness)` | iOS グレー基調のモノクロ配色（黒／白がプライマリ） |
| `SkColorSchemes.seeded(seed, primary:)` | シード色から作る配色。プライマリだけ固定も可 |

### 部品

| 名前 | 内容 |
| --- | --- |
| `SkChoiceChip` | 選択時はプライマリで塗りつぶすだけ（チェックマークなし・枠線の太さも変えない） |
| `SkSegmentedControl` | 横幅いっぱいの単一選択の切り替え。選択中をプライマリで塗る |
| `SkSectionHeader` | 画面内のまとまりの見出し。右端に trailing |
| `SkPanel` | 影なし・細い枠線の平らなカード。onTap 可 |
| `SkEmptyState` | アイコン・タイトル・説明・ボタンの空状態 |
| `SkPill` | 状態や件数を示す小さなラベル |
| `SkSettingsSection` / `SkSettingsTile` | 設定画面のグループと行 |
| `SkMetricTile` | ラベル付きの数値（等幅数字） |
| `SkSheetHandle` / `showSkBottomSheet` | シートの取っ手と、共通設定のモーダルシート |
| `showSkConfirmDialog` | はい／いいえの確認ダイアログ（destructive 対応） |
| `SkSnackBar.show` | 積み上がらないスナックバー |
| `SkLoadingOverlay` | 画面を覆う処理中表示 |

文言はすべて呼び出し側から渡します（パッケージ側では多言語化しません）。

公開名にはすべて `Sk` 接頭辞を付けています。アプリ側の `AppColors` や `AppTheme` などと
名前が衝突しないので、`show` / `hide` なしでそのまま import できます。

## 導入方法（git 依存）

アプリの `pubspec.yaml` に追加します。

```yaml
dependencies:
  sokuma_ui:
    git:
      url: https://github.com/SOKu-ma/sokuma_ui.git
      ref: v0.2.0 # タグで固定する
```

```dart
import 'package:sokuma_ui/sokuma_ui.dart';

// モノクロ配色のアプリ
MaterialApp(
  theme: buildSkTheme(colorScheme: SkColorSchemes.monochrome(Brightness.light)),
  darkTheme: buildSkTheme(colorScheme: SkColorSchemes.monochrome(Brightness.dark)),
  home: ...,
);

// シード色で配色するアプリ
const seed = Color(0xFF00897B);
MaterialApp(
  theme: buildSkTheme(seedColor: seed),
  darkTheme: buildSkTheme(seedColor: seed, brightness: Brightness.dark),
  home: ...,
);

SkChoiceChip(
  label: 'FW',
  selected: position == 'FW',
  onSelected: (_) => setState(() => position = 'FW'),
);
```

バージョンを上げるときは `ref` を新しいタグに変えて `flutter pub upgrade sokuma_ui` を実行します。

## ローカル開発（dependency_overrides）

sokuma_ui を手元で修正しながらアプリで確認したいときは、`dependency_overrides` で
ローカルのパスを参照させます。

1. sokuma_ui をアプリの隣などに clone する

   ```
   ~/dev/
   ├── sokuma_ui/
   └── my_app/
   ```

2. アプリ側に `pubspec_overrides.yaml` を作成する（`pubspec.yaml` は書き換えない）

   ```yaml
   # my_app/pubspec_overrides.yaml
   dependency_overrides:
     sokuma_ui:
       path: ../sokuma_ui
   ```

3. `flutter pub get` を実行する。以後 sokuma_ui の変更がホットリロードで反映されます。

4. 確認が終わったら sokuma_ui 側でコミット・タグ付けして push し、アプリ側は
   `pubspec_overrides.yaml` を削除して `pubspec.yaml` の `ref` を新しいタグに更新します。

`pubspec_overrides.yaml` はうっかりコミットしないよう、アプリ側の `.gitignore` に
追加しておくのがおすすめです。`pubspec.yaml` に直接 `dependency_overrides:` を
書いても同じように動きますが、その場合はコミット前に必ず消してください。

## example

部品とテーマの見た目は、ブラウザで確認できます（main への push ごとに自動更新）。

**https://www.so-kuma.com/sokuma_ui/**

ソースは `example/` にあります。手元で動かす場合は次のとおりです。

```sh
cd example
flutter run
```

## リリース手順

1. `pubspec.yaml` の `version` と `CHANGELOG.md` を更新
2. コミットして `git tag v<version>` → `git push --tags`

## License

MIT
