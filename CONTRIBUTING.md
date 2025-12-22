# Contributing to HTTP Mock Lib

Thank you for considering contributing to **HTTP Mock Lib**! 🙌
We welcome contributions that improve performance, add features, fix bugs, or enhance documentation and tests.

## 🚀 How to Contribute

To contribute to this project, please follow the standard GitHub fork-and-pull workflow:

### 1. Fork the Repository

Start by [forking the repository](https://github.com/beyond-the-cloud-dev/http-mock-lib/fork) to your own GitHub account.

### 2. Clone Your Fork

```bash
git clone https://github.com/YOUR_USERNAME/http-mock-lib.git
cd http-mock-lib
```

### 3. Create a New Branch

```bash
git checkout -b feature/my-awesome-feature
```

### 4. Make Your Changes

Make your changes in the appropriate files. Please follow the current coding style and conventions used in the codebase.

- For Apex classes: follow existing patterns in HttpMock.cls
- For documentation: update relevant markdown files in `website/`

If you're updating logic, add or update unit tests.

### 5. Run Tests

Before committing, ensure all tests pass:

```bash
sf apex run test -o dev -l RunLocalTests
```

### 6. Commit and Push

```bash
git add .
git commit -m "feat: add support for XYZ feature"
git push origin feature/my-awesome-feature
```

Use conventional commit messages:

- `feat:` - New feature
- `fix:` - Bug fix
- `docs:` - Documentation changes
- `test:` - Adding or updating tests
- `chore:` - Maintenance tasks

### 7. Open a Pull Request

Open a Pull Request (PR) from your fork to the main branch of the original repository:

```
https://github.com/beyond-the-cloud-dev/http-mock-lib
```

- Base: `main`
- Compare: your feature branch

Please include:

- Clear description of the changes
- Code examples if applicable
- Reference to related issues

## ✅ Pull Request Checklist

Before submitting your PR, make sure you've:

- [ ] Written clear and concise commit messages
- [ ] Followed existing code style and naming conventions
- [ ] Added or updated relevant documentation (if applicable)
- [ ] Added or updated unit tests (if applicable)
- [ ] Verified that all existing tests pass
- [ ] Updated the documentation site if needed

## 📝 Types of Contributions

We welcome the following types of contributions:

### Code Contributions

- New HTTP mock features
- Additional HTTP methods or status codes
- CI/CD improvements
- Test coverage improvements

### Documentation Contributions

- Fix typos or clarify existing docs
- Add new guides or examples
- Improve API documentation
- Add code snippets and best practices

### Bug Reports

- Use GitHub Issues to report bugs
- Include reproduction steps
- Provide error messages and logs
- Mention your Salesforce API version

### Feature Requests

- Use GitHub Issues to suggest features
- Describe the use case
- Explain why it would benefit the library

## 🛠 Development Setup

```bash
# Create scratch org for testing
sf org create scratch -f config/project-scratch-def.json -a dev
sf project deploy start -o dev

# Run tests
sf apex run test -o dev -l RunLocalTests
```

## 💬 Questions?

If you have questions about contributing:

- Check existing [Issues](https://github.com/beyond-the-cloud-dev/http-mock-lib/issues)
- Create a new issue for questions

Thank you for helping make HTTP Mock Lib better! 🚀
