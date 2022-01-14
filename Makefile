start:
	docker-compose up --abort-on-container-exit

compose-logs:
	docker-compose logs -f valheim

setup: prepare-vault-password install

prepare-vault-password:
	touch vault-password

set-vault-password:
	echo "$(PASSWORD)" > vault-password

install:
	ansible-galaxy install -r requirements.yml

ping:
	ansible -i inventory.ini all -m ping

uptime:
	ansible -i inventory.ini all -a "uptime"

deploy:
	ansible-playbook playbook.yml -i inventory.ini

create-vault:
	ansible-vault create $(FILE) --vault-password-file vault-password

edit-vault:
	ansible-vault edit $(FILE) --vault-password-file vault-password

view-vault:
	ansible-vault view $(FILE) --vault-password-file vault-password
