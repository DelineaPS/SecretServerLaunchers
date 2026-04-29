# Chrome

Four Chrome launcher variants, each useful for a different scenario:

1. [Incognito with prompted URL](#variant-1--incognito)
2. [Launch as another OS user with prompted URL](#variant-2--launch-as-other-user)
3. [Multiple URLs on a Web Password template](#variant-3--multiple-urls-on-a-web-password-template)
4. [Launcher whitelist](#variant-4--launcher-whitelist)

---

## Variant 1 — Incognito

| Launcher field | Value |
|---|---|
| Process Name | `"C:\Program Files (x86)\Google\Chrome\Application\chrome"` |
| Process Arguments | `-incognito $URL` |
| Run Process As Secret Credentials | No |
| Load User Profile | No |
| Use Operating System Shell | No |

Map the secret template's URL field (or **Additional Prompt Field Name** = `URL`) to `$URL`.

---

## Variant 2 — Launch as other user

Useful when the user running Secret Server has Chrome open under their own profile but you need a clean Chrome instance signed in as the secret's identity.

### Launcher

| Launcher field | Value |
|---|---|
| Launcher Name | `Chrome` |
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

Tip: set **Restrict User Input** = Yes plus a whitelist if you want users to pick from a fixed list of URLs (see Variant 3 / Variant 4 below).

### Web Password Filler integration

To get the existing Web Password Filler (WPF) flow alongside this launcher, also add:

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

1. **Admin → Secret Templates → Configure Launchers → New**.
2. Process launcher pointing at your `chrome.exe`.
3. Tick **Use Additional Prompt** and set **Additional Prompt Field Name** to `URL`.

### Template attachment

1. **Admin → Secret Templates** → pick **Web Password** → **Edit**.
2. **Configure launcher → Add new launcher**.
3. Map URL → URL, Username → Username, Password → Password.

### Multi-URL format

In the secret's URL field, comma-separate URLs:

```
https://website1.com, https://website2.com
```

When the launcher fires, the user picks the URL from a dropdown.

---

## Variant 4 — Launcher Whitelist

Restricts launches to a curated list of URLs from the secret's URL field. Combines well with Variant 2 (launch as other user) for jump-host-style scenarios.

### Launcher

| Launcher field | Value |
|---|---|
| Launcher Type | Process |
| Launcher Name | `Chrome` |
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
