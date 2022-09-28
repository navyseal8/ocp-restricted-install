
/path/to/ccoctl aws create-iam-roles \
--name=<name>  \
--region=ap-southeast-1 \
--credentials-requests-dir=/path/to/credrequests \
--identity-provider-arn=arn:aws:iam::xxxxxx:oidc-provider/xxx-oidc.s3.ap-southeast-1.amazonaws.com
