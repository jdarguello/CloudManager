def "main infra" [] {
    print (
"Description:
    Operaciones de infraestructura con Terraform.

Usage:
    manager infra <parameter>

Parameters:
    setup:          Levanta la infraestructura base (VPCs, subnets y clusters EKS)
    teardown:       Destruye toda la infraestructura del proyecto.

Flags:
    --dry-run       Especifica si sólo desea planear la acción sin ejecutarla
"
    )
}

def --env "main infra setup" [
    --dry-run="server"      #Define si se aplica la infraestructura o sólo el plan de Terraform
] {
    #1. Ir al directorio de infra
    let current_directory = pwd
    cd ../../infra/clusters
    #2. Ejecutar el plan de Terraform ($dry_run == "client")
    if $dry_run == "client" {
        terraform plan --var=github_token=$env.GITHUB_TOKEN
    }
    #3. Ejecutar terraform (($dry_run == "server"))
    if $dry_run == "server" {
        terraform init
        terraform apply --var=github_token=$env.GITHUB_TOKEN -auto-approve
    }

    #4. Limpieza
    #terraform state rm kubernetes_namespace.flux_system
    #terraform state rm kubernetes_namespace.crossplane_system

    #5. Regresa al directorio base del CLI
    cd $current_directory
}

def --env "main infra teardown" [] {
    cd ../../infra/clusters
    terraform destroy --var=github_token=$env.GITHUB_TOKEN -auto-approve
}