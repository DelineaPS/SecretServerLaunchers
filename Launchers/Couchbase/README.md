# Couchbase Cluster

Browser-based launcher for Couchbase clusters. Each Couchbase cluster's nodes have their own administration URLs; this launcher lets you store one secret per cluster (with all the node URLs in the URL field) and prompts the operator to pick a node at launch.

The pattern is the same as [Chrome – Multiple URLs / Whitelist](../Chrome) but configured for any browser, with a Couchbase-specific note about cluster URL formatting.

## Cluster URL format

In the secret's URL field, comma-separate every node URL. Include a space after each comma:

```
http://10.10.10.65:5191, http://10.10.10.66:5191, http://10.10.10.67:5191
```

(`5191` is just an example admin port — substitute your cluster's actual port.)

## Create launcher

1. **Admin → Secret Templates → Configure Launchers → New**.
2. Enter a **Launcher Name** — e.g. `Couchbase`.
3. Check **Use Additional Prompt**.
4. **Additional Prompt Field Name**: `$URL`.
5. **Process Name**: the path to your preferred browser (e.g. `chrome`, `msedge`, `firefox`).
6. **Process Arguments**: `"$URL"` (include the double quotes).
7. Click **Save**.

You can append browser-specific switches to **Process Arguments** if you want — e.g. `-incognito "$URL"` for Chrome, `-private-window "$URL"` for Firefox, `-inprivate "$URL"` for Edge.

## Configure template launcher

1. **Admin → Secret Templates** → pick your Couchbase template → **Edit**.
2. **Configure Launcher → Add New Launcher**.
3. **Launcher Type to use**: `Couchbase` (or whatever you named the launcher).
4. Map fields:
   - **URL** → `<user input>`
   - **Domain** → `<blank>`
   - **Password** → Password
   - **Username** → Username
5. Check **Restrict User Input**.
6. **Restrict As**: `Allowed List`.
7. **Restrict By Secret Field**: `URL`.
8. Click **Save**.

The user will get a dropdown of the cluster's node URLs at launch.

## Verifying

Create a secret on this template with a real cluster's URLs in the **URL** field, click the launcher, and confirm the dropdown shows each node URL and the chosen URL opens in your browser.
