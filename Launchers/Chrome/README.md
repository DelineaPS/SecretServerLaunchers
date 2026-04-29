# Chrome

[Google Chrome](https://www.google.com/chrome/) launcher variants, each useful for a different scenario:

1. [Incognito with prompted URL](#variant-1--incognito)
2. [Launch as another OS user with prompted URL](#variant-2--launch-as-other-user)
3. [Multiple URLs on a Web Password template](#variant-3--multiple-urls-on-a-web-password-template)
4. [Launcher whitelist](#variant-4--launcher-whitelist)

---

## Variant 1 — Incognito

| Launcher field | Value |
|---|---|
| Launcher Name | `Chrome - Incognito` |
| Launcher Type | Process |
| Active | Yes |
| Additional Prompt Field Name | `URL` |
| Wrap custom parameters with quotation marks | Yes |
| Process Name | `"C:\Program Files (x86)\Google\Chrome\Application\chrome"` |
| Process Arguments | `-incognito $URL` |
| Run Process As Secret Credentials | No |
| Load User Profile | No |
| Use Operating System Shell | No |

Map the secret template's `URL` field (or use **Additional Prompt Field Name** = `URL` to prompt) to `$URL`.

---

## Variant 2 — Launch as other user

Useful when the user running Secret Server has Chrome open under their own profile but needs a clean Chrome instance signed in as the secret's identity.

| Launcher field | Value |
|---|---|
| Launcher Name | `Chrome` |
| Launcher Type | Process |
| Active | Yes |
| Additional Prompt Field Name | `URL` |
| Wrap custom parameters with quotation marks | Yes |
| Process Name | `"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"` |
| Process Arguments | `$URL` |
| Run Process As Secret Credentials | Yes |
| Load User Profile | Yes |
| Use Operating System Shell | No |

### Template launcher mapping

| Template field | Map to |
|---|---|
| Domain | Domain |
| Password | Password |
| URL | `<user input>` |
| Username | Username |
| Restrict User Input | No |

> [!TIP]
> Set **Restrict User Input** = Yes with a whitelist to give users a fixed list of URLs to pick from — see Variant 3 and Variant 4 below.

### Web Password Filler integration

To get the existing Web Password Filler (WPF) flow alongside this launcher, also add a second launcher to the template:

| Template field | Map to |
|---|---|
| Launcher Type to use | Website Login |
| Password | Password |
| URL | URL |
| Username | Username |

---

## Variant 3 — Multiple URLs on a Web Password template

Lets a single secret carry several URLs and prompt the user to pick one at launch.

### Launcher

| Launcher field | Value |
|---|---|
| Launcher Name | `Chrome - Multiple URLs` |
| Launcher Type | Process |
| Active | Yes |
| Use Additional Prompt | Yes |
| Additional Prompt Field Name | `URL` |
| Process Name | `"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"` |
| Process Arguments | `$URL` |
| Run Process As Secret Credentials | No |
| Load User Profile | No |
| Use Operating System Shell | No |

### Template attachment

Edit the **Web Password** template → **Configure Launcher** → **Add new launcher**. Map URL → URL, Username → Username, Password → Password.

### Multi-URL format

In the secret's URL field, comma-separate URLs:

```
https://website1.com, https://website2.com
```

When the launcher fires, the user picks the URL from a dropdown.

---

## Variant 4 — Launcher Whitelist

Restricts launches to a curated list of URLs from the secret's URL field. Combines well with Variant 2 (launch as other user) for jump-host-style scenarios.

| Launcher field | Value |
|---|---|
| Launcher Name | `Chrome` |
| Launcher Type | Process |
| Active | Yes |
| Use Additional Prompt | Yes |
| Additional Prompt Field Name | `URL` |
| Wrap custom parameters with quotation marks | Yes |
| Process Name | `"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"` |
| Process Arguments | `$URL` |
| Run Process As Secret Credentials | Yes |
| Load User Profile | Yes |
| Use Operating System Shell | No |

### Template launcher mapping (with whitelist)

| Template field | Value |
|---|---|
| Domain | Domain |
| Password | Password |
| URL | `<user input>` |
| Username | Username |
| Restrict User Input | Yes |
| Restrict As | Whitelist |
| Restrict By Secret Field | URL |
| Include Machines From Dependencies | No |

When configured this way, the launch dialog presents a dropdown populated from the comma-separated URL field of the secret.
