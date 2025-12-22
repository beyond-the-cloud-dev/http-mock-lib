# Installation

This guide covers the different ways to install HTTP Mock Lib in your Salesforce org.

## Using Salesforce CLI

The recommended way to install HTTP Mock Lib is using the Salesforce CLI.

### 1. Install as an Unlocked Package

```bash
sf package install --package 0HoRG00000000XXXXXXX --target-org your-org-alias --wait 10
```

::: tip
Replace `your-org-alias` with your org alias or username.
:::

### 2. Deploy Source Code

Clone the repository and deploy directly:

```bash
# Clone the repository
git clone https://github.com/beyond-the-cloud-dev/http-mock-lib.git
cd http-mock-lib

# Deploy to your org
sf project deploy start --target-org your-org-alias
```

## Manual Installation

### Using Workbench

1. Download the source code from [GitHub](https://github.com/beyond-the-cloud-dev/http-mock-lib)
2. Navigate to [Workbench](https://workbench.developerforce.com/)
3. Login to your org
4. Go to **Migration** → **Deploy**
5. Select the `force-app` folder and deploy

### Using Setup UI

1. Copy the class code from [HttpMock.cls](https://github.com/beyond-the-cloud-dev/http-mock-lib/blob/main/force-app/main/default/classes/HttpMock.cls)
2. In your Salesforce org, go to **Setup** → **Apex Classes**
3. Click **New**
4. Paste the code and click **Save**

## Dependencies

HTTP Mock Lib has **zero dependencies**. It's a standalone library that works out of the box.

## API Version

HTTP Mock Lib requires Salesforce API version **64.0** or higher.

## Verification

To verify the installation, create a simple test:

```apex
@IsTest
private class HttpMockVerificationTest {
  @IsTest
  static void verifyInstallation() {
    new HttpMock()
      .whenGetOn('/test')
      .body('{"test": true}')
      .statusCodeOk()
      .mock();

    // If this compiles and runs, installation is successful
    Assert.isTrue(true);
  }
}
```

Run the test:

```bash
sf apex run test --class-names HttpMockVerificationTest --target-org your-org-alias
```

If the test passes, HTTP Mock Lib is installed correctly! ✅

## Next Steps

Now that you have HTTP Mock Lib installed, check out:

- [Getting Started Guide](/getting-started)
- [API Reference](/api/)
- [Examples](/examples/basic)

## Troubleshooting

### API Version Error

**Error:** `Invalid API version specified`

**Solution:** Ensure your org supports API version 64.0 or higher. You can check this in Setup → API.

### Deployment Fails

**Error:** `Deployment failed`

**Solution:**
- Verify you have sufficient permissions
- Check that your org is not at maximum capacity for Apex classes
- Review any error messages for specific issues

### Need Help?

If you encounter any issues:
- Check [GitHub Issues](https://github.com/beyond-the-cloud-dev/http-mock-lib/issues)
- Create a new issue if your problem isn't listed
- Contact [Beyond the Cloud](https://beyondthecloud.dev)
