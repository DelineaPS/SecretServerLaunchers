# Couchbase Cluster

Browser-based launcher for [Couchbase](https://www.couchbase.com/) clusters. Each Couchbase cluster's nodes have their own administration URLs; this launcher lets one secret per cluster store all node URLs in the URL field, then prompts the operator to pick a node at launch.

The pattern is the same as [Chrome – Multiple URLs / Whitelist](../Chrome) but configured for any browser, with a Couchbase-specific note about cluster URL formatting.

## Cluster URL format

In the secret's URL field, comma-separate every node URL. Include a space after each comma:

```
http://10.10.10.65:5191, http://10.10.10.66:5191, http://10.10.10.67:5191
```

(`5191` is just an example admin port — substitute the cluster's actual port.)

## Launcher

| Launcher field | Value |
|---|---|
| Launcher Name | `Couchbase` |
| Launcher Type | Process |
| Active | Yes |
| Use Additional Prompt | Yes |
| Additional Prompt Field Name | `URL` |
| Process Name | path to the preferred browser (e.g. `chrome`, `msedge`, `firefox`) |
| Process Arguments | `"$URL"` |
| Run Process As Secret Credentials | No |
| Load User Profile | No |
| Use Operating System Shell | No |

Append browser-specific switches to **Process Arguments** as needed — e.g. `-incognito "$URL"` for Chrome, `-private-window "$URL"` for Firefox, `-inprivate "$URL"` for Edge.

## Template launcher mapping

| Template field | Map to |
|---|---|
| Launcher Type to use | `Couchbase` (this launcher) |
| URL | `<user input>` |
| Domain | `<blank>` |
| Password | Password |
| Username | Username |
| Restrict User Input | Yes |
| Restrict As | `Allowed List` |
| Restrict By Secret Field | `URL` |

The user gets a dropdown of the cluster's node URLs at launch.

## Verifying

Create a secret on this template with a real cluster's URLs in the **URL** field, click the launcher, and confirm the dropdown shows each node URL and the chosen URL opens in the browser.
