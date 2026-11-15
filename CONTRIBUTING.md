# Contributing to Drozio

Thank you for your interest in contributing to Drozio! To maintain code quality and ensure a smooth collaboration, please follow the guidelines below.

---

## 🌿 Branching Strategy

We follow the standard Gitflow workflow:
- `main`: Production-ready code only. All direct commits are blocked; changes must be merged via Pull Requests.
- `develop`: Primary staging and integration branch.
- `feature/<feature-name>`: Dedicated branches for new features created off `develop`.
- `fix/<bug-name>`: Bug fix branches created off `develop`.
- `hotfix/<patch-name>`: Urgent production fixes branched directly off `main`.

---

## 💻 Development Workflow

1. **Fork or Clone the Repository:**
   ```bash
   git clone https://github.com/Diploy-Space/Drozio.git
   cd Drozio
   ```

2. **Create a Feature Branch:**
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Coding Standards:**
   - **Flutter/Dart:** Follow official [Effective Dart](https://dart.dev/effective-dart) style guide.
   - **Laravel/PHP:** Adhere to PSR-12 coding standard.
   - Maintain Clean Architecture boundaries between `controllers`, `domain`, and `presentation`.

4. **Run Static Analysis:**
   Ensure your changes introduce zero errors, warnings, or lints:
   ```bash
   dart analyze "User app"
   dart analyze "Vendor app"
   ```

5. **Commit Message Guidelines:**
   Use [Conventional Commits](https://www.conventionalcommits.org/):
   - `feat: add live auction countdown badge`
   - `fix: resolve crash on checkout empty cart`
   - `docs: update installation instructions`
   - `refactor: extract reusable POS customer dropdown`

6. **Submit a Pull Request:**
   - Open a PR targeting `develop` (or `main` for critical patches).
   - Fill out the PR template completely with screenshots if UI changed.
   - Ensure the automated CI analysis passes.
