# terraform-aws-dev

個人開発アプリケーション用のAWS環境を構築するTerraformのソースコードです。<br>
~~stateファイルはTerraform Cloudで管理しています。~~

## Setup

Git管理外の各種ファイルを指定ディレクトリに配置します。

```
terraform-aws-dev
  ├ env/dandoh-dev
  │  ├ terraform.tfstate
  │  └ terraform.tfvars
  └ modules/ec2/ssh_key
      ├ ec2_keypair
      └ ec2_keypair.pub
```
