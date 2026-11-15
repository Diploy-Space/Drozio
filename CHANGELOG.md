# Changelog

All notable changes to the Drozio multi-vendor ecosystem will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [16.6.1] - 2026-11-15

### Added
- **Repository Architecture:** Organized GitHub repository with complete developer guidelines, CI/CD automated static analysis workflows, issue/PR templates, and modular READMEs.
- **Dependencies:** Added direct dependencies `collection` and `html` to User App, and `html` and `image` to Vendor App.

### Fixed
- **User App:**
  - Resolved unhandled `DioException` connection errors and SSL bad certificates in API exception handlers.
  - Removed dead code, write-only variables, and unreferenced fields.
  - Attained 100% clean static analysis (`0 errors, 0 warnings, 0 infos`).
- **Vendor App:**
  - Corrected malformed file name `edit _product_bottomsheet.dart` to `edit_product_bottomsheet.dart`.
  - Fixed constructor syntax errors and invalid colon separators in `auction_filter_widget.dart`, `order_list_filter_bottomsheet_widget.dart`, and `product_details_widget.dart`.
  - Fixed logic bug comparing `ProductTypeEnum?.name` against `List<String>?` in product filter.
  - Eliminated duplicate unreachable switch cases in `api_error_handler.dart`.
  - Upgraded deprecated `Radio` widgets to Flutter 3.47+ `RadioGroup`.
  - Guarded async `BuildContext` usages with `mounted` checks.
  - Cleaned unreferenced private widgets (`_StatusFilterWidget`, `_FieldTile`, `_ValueTile`).
  - Attained 100% clean static analysis (`0 errors, 0 warnings, 0 infos`).

---

## [16.6.0] - 2026-10-15
- Base upgrade release from 6valley V16.5 to V16.6.
- Added live auction support, Gemini AI assistance, and wholesale tiered pricing.
