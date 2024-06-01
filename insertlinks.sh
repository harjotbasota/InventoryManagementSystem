#!/bin/bash
cd ~/InventoryManagementSystem/Infrastructure/apigateway
invoke_url=$(terraform output invoke_url)
invoke_url=${invoke_url#\"}
invoke_url=${invoke_url%\"}
hosted_ui_url=$(terraform output hosted_ui_url)
hosted_ui_url=${hosted_ui_url#\"}
hosted_ui_url=${hosted_ui_url%\"}
logout_url=$(terraform output logout_url)
logout_url=${logout_url#\"}
logout_url=${logout_url%\"}
cd ../../frontend
echo "Invoke URL: $invoke_url"
echo "Login URL: $hosted_ui_url"
echo "Logout URL: $logout_url"
for file in delete.html get.html update.html upload.html
do
  sed -i "s|fetch(\"#\", requestOptions)|fetch(\"${invoke_url}/api\", requestOptions)|g" "$file"
done
sed -i "s|fetch(\"#\", requestOptions)|fetch(\"${invoke_url}/search\", requestOptions)|g" getfiltered.html
sed -i "s|#1|${hosted_ui_url//&/\\&}|g" index.html
sed -i "s|#2|${logout_url//&/\\&}|g" index.html