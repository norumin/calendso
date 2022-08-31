set dotenv-load
set positional-arguments

# List available recipes
default:
  just --list

# Wrap terragrunt with dotenv loading
@tg *args='':
  terragrunt "$@"

# Initialize terragrunt and tflint
init:
  tflint --init
  terragrunt init

# Terragrunt output in json format (into output.json)
output:
	terragrunt output -json > output.json

# Generate terraform graph and convert into svg format (requires graphviz)
graph:
	terragrunt graph -draw-cycles > graph.gv && dot -Tsvg graph.gv > graph.svg

# Generate a new keypair
keygen:
	ssh-keygen -t rsa -m PEM -f .keypair.pem -N '' -C '' && chmod 400 .keypair.pem

# Format tf files
fmt:
	terraform fmt -recursive

# Format hcl files
hclfmt:
	terragrunt hclfmt

# Lint project (by tflint)
lint:
	tflint

# Generate terraform documentation in markdown
tfdocs:
	terraform-docs . -c .terraform-docs.yml

# Check if output.json file exists
check-output:
	test -f output.json
