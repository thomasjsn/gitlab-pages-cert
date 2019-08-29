# GitLab pages certificate

Looks for certificates and keys under `~/.acme.sh/`, which is where acme.sh puts it.

Created a SHA checksum of the certificate, will not upload new certificate if it has not changed.

GitLab token must be pasted into `.token` file.

## Usage

### Create
Create new GitLab page for project and upload certificate.

```
$ ./pages.sh create projectID gitlab-pages-domain certificate-domain
```

### Update
Update existing LitLab page with new certificate.

```
$ ./pages.sh update projectID gitlab-pages-domain certificate-domain
```
