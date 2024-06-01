#!/bin/bash
cd ./apigateway
invoke_url=$(terraform output invoke_url)
invoke_url=${invoke_url#\"}
invoke_url=${invoke_url%\"}
hosted_ui_url=$(terraform output hosted_ui_url)
hosted_ui_url=${hosted_ui_url#\"}
hosted_ui_url=${hosted_ui_url%\"}
logout_url=$(terraform output logout_url)
logout_url=${logout_url#\"}
logout_url=${logout_url%\"}
cd ..
echo "Invoke URL: $invoke_url"
echo "Login URL: $hosted_ui_url"
echo "Logout URL: $logout_url"
for file in myfile.html
do
  sed -i "s|fetch(\"#\", requestOptions)|fetch(\"${invoke_url}/api\", requestOptions)|g" "$file"
done
sed -i "s|fetch(\"#\", requestOptions)|fetch(\"${invoke_url}/search\", requestOptions)|g" getfiltered.html
old_string='<a id="authlinks" href="#"> Login</a>'
new_string='<a id="authlinks" href="'${hosted_ui_url}'"> Login</a>'
sed -i "s|$old_string|$new_string|g" index.html
old_string='<a id="authlinks" href="#"> Logout</a>'
new_string='<a id="authlinks" href="'${logout_url}'"> Logout</a>'
sed -i "s|$old_string|$new_string|g" index.html