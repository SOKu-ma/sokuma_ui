# sokuma_ui

個人開発している複数の Flutter アプリで、見た目と操作感をそろえるためのデザインシステムです。

## このパッケージについて

- **自分のアプリ用に育てているもの**です。汎用 UI ライブラリを目指してはおらず、
  部品は実際のアプリで必要になったものだけを追加します。
- **破壊的変更がありえます。** バージョンが 1.0 未満のあいだは、マイナーバージョンでも
  API が変わることがあります。利用する側では `ref` でタグを固定してください。
- pub.dev には公開していません。git 依存で利用します。

## 含まれるもの

| 種類 | 名前 | 内容 |
| --- | --- | --- |
| トークン | `AppColors` | 既定シード色、success / warning / error |
| トークン | `AppSpacing` | 余白（xs 4 / sm 8 / md 16 / lg 24 / xl 32） |
| トークン | `AppRadius` | 角丸（sm / md / lg / full） |
| トークン | `AppTextStyles` | headline / title / body / label / caption |
| テーマ | `buildAppTheme(seedColor:)` | シード色からアプリごとのテーマを生成 |
| 部品 | `AppChoiceChip` | 選択時はプライマリで塗りつぶすだけ（チェックマークなし・枠線の太さも変えない）。ライト / ダーク対応 |

## 導入方法（git 依存）

アプリの `pubspec.yaml` に追加します。

```yaml
dependencies:
  sokuma_ui:
    git:
      url: https://github.com/SOKu-ma/sokuma_ui.git
      ref: v0.1.0 # タグで固定する
```

```dart
import 'package:sokuma_ui/sokuma_ui.dart';

const seed = Color(0xFF00897B);

MaterialApp(
  theme: buildAppTheme(seedColor: seed),
  darkTheme: buildAppTheme(seedColor: seed, brightness: Brightness.dark),
  home: ...,
);

AppChoiceChip(
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

**https://soku-ma.github.io/sokuma_ui/**

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
