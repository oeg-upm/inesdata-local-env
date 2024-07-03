#! /bin/sh

function import_direct_secrets() {
    echo ">>>>>> Importing secrets from properties"

    # folder with secrets
    secret_folder="/var/init-secrets"

    # Get the files in the folder
    for secret_file in "$secret_folder"/*; do
      # Check that it is a file and not a folder
      if [ -f "$secret_file" ]; then
        echo ">>>> Processing file '$secret_file'"

        import_secrets_from_file $secret_file
      fi
    done
}

function import_json_secrets() {
    echo ">>>>>> Importing JSON secrets"

    # folder with secrets
    json_secrets_folder="/var/init-json-secrets"

    # Get the JSON files in the folder
    for json_secrets_file in "$json_secrets_folder"/*.json; do
      echo ">>>> Processing JSON file '$json_secrets_file'"

      secret_filename="${json_secrets_file##*/}"
      secret_name="${secret_filename%.*}"
      vault kv put secret/$secret_name @$json_secrets_file
    done
}

function import_secrets_from_file() {
    secretsfile=$1

    echo ">>>>>> Importing secrets from properties file '$secretsfile'"

    # Read the file line by line
    while IFS='=' read -r key value; do
        # Check that it is not an empty line or a comment
        if [[ -n "$key" && -n "$value" && ! "$key" =~ ^# ]]; then
            # Create the secret
            vault kv put secret/$key content="$value"

            echo ">>>>>> Added the secret '$key'"
        fi
    done < "$secretsfile"
}


# Authenticate to Vault
echo ">> Authenticate into Vault"
vault login $VAULT_TOKEN

# process secrets from properties
import_direct_secrets

# process folder with json secrets
import_json_secrets

echo ">> Setup done"