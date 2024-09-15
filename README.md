# Azure MLOps Random Regressor

Welcome to the **Azure MLOps Random Regressor** project! This repository showcases a complete MLOps (Machine Learning Operations) pipeline implemented using Azure Machine Learning. The project includes data management, model training, evaluation, and deployment pipelines for both batch inference and real-time online endpoints.

```mermaid
graph TD
    A[GitHub Repository] --> B[GitHub Actions]
    B --> C[Terraform Scripts]
    C --> D[Azure Infrastructure]
    D --> E[Azure Machine Learning]
    A --> F[GitHub Packages]
    F --> G[Docker Images]
    E --> H[Model Training Pipeline]
    E --> I[Batch Deployment Pipeline]
    E --> J[Online Deployment Pipeline]
    H --> K[Datasets (/data)]
    I --> L[Batch Endpoint]
    J --> M[Online Endpoint]
    L --> N[Batch Inference Users]
    M --> O[Real-time Users]
    
    subgraph CI/CD
        B
        C
        F
    end
    
    subgraph Azure Services
        D
        E
        I
        J
        L
        M
    end
    
    subgraph Users
        N
        O
    end


## Table of Contents

- [Project Overview](#project-overview)
- [Project Structure](#project-structure)
- [Prerequisites](#prerequisites)
- [Setup](#setup)
- [Pipelines](#pipelines)
  - [Training Pipeline](#training-pipeline)
  - [Batch Deployment Pipeline](#batch-deployment-pipeline)
  - [Online Deployment Pipeline](#online-deployment-pipeline)
- [Infrastructure as Code](#infrastructure-as-code)
- [Continuous Integration/Continuous Deployment (CI/CD)](#continuous-integrationcontinuous-deployment-cicd)
- [Data](#data)
- [Model Development](#model-development)
- [Environment](#environment)
- [Contributing](#contributing)
- [License](#license)

## Project Overview

This project demonstrates how to implement MLOps best practices using Azure Machine Learning. It includes:

- **Data Management:** Organizing and registering datasets with Azure ML.
- **Model Training:** Training a Random Regressor model using a defined pipeline.
- **Model Evaluation:** Assessing model performance and registering the best model.
- **Deployment Pipelines:** Deploying models for batch inference and creating real-time online endpoints.
- **Infrastructure as Code:** Managing Azure resources using Terraform.
- **CI/CD Pipelines:** Automating workflows with GitHub Actions.

## Project Structure

```plaintext
azure-mlops-random-regressor/
│
├── .github/                           # GitHub Actions workflows
│   └── workflows/
│       ├── codeql.yml                 # Code quality and security analysis
│       ├── deploy-batch-endpoint-pipeline.yml  # Batch deployment workflow
│       ├── deploy-model-training-pipeline.yml   # Training pipeline workflow
│       ├── deploy-online-endpoint-pipeline.yml  # Online deployment workflow
│       └── tf-gha-deploy-infra.yml               # Infrastructure deployment workflow
├── data/                              # Datasets for training and inference
│   ├── taxi-batch.csv                 # Batch inference data
│   ├── taxi-data.csv                  # Training data
│   └── taxi-request.json              # Sample request for online inference
├── data-science/                      # Source code for data science workflows
│   ├── src/                           # Python scripts
│   │   ├── evaluate.py                # Model evaluation script
│   │   ├── prep.py                    # Data preparation script
│   │   ├── register.py                # Model registration script
│   │   └── train.py                   # Model training script
│   └── environment/                   # Environment definitions
│       └── train-conda.yml            # Conda environment for training
├── infrastructure/                    # Infrastructure as Code (Terraform)
│   ├── modules/                       # Terraform modules
│   │   ├── aml-workspace/             # Azure ML Workspace module
│   │   ├── application-insights/      # Application Insights module
│   │   ├── container-registry/        # Container Registry module
│   │   ├── data-explorer/             # Data Explorer module
│   │   ├── key-vault/                 # Key Vault module
│   │   ├── resource-group/            # Resource Group module
│   │   └── storage-account/           # Storage Account module
│   ├── aml_deploy.tf                  # Azure ML deployment configuration
│   ├── locals.tf                      # Local variables for Terraform
│   ├── main.tf                        # Main Terraform configuration
│   └── variables.tf                   # Variable definitions for Terraform
├── mlops/                             # MLOps pipelines and configurations
│   └── azureml/
│       ├── train/                     # Training pipeline configurations
│       └── deploy/                    # Deployment pipeline configurations
│           ├── batch/                 # Batch deployment configurations
│           │   ├── batch-deployment.yml
│           │   └── batch-endpoint.yml
│           └── online/                # Online deployment configurations
│               ├── online-deployment.yml
│               └── online-endpoint.yml
├── devops-pipelines/                  # DevOps pipeline definitions
├── config-infra-dev.yml               # Development infrastructure config
├── config-infra-prod.yml              # Production infrastructure config
├── deploy_batch.sh                    # Script to deploy batch endpoint
├── deploy_endpoint.sh                 # Script to deploy online endpoint
├── environment.yml                    # Global environment configuration
├── requirements.txt                   # Python dependencies
├── run_training.sh                    # Script to run the training pipeline
├── terraform.sh                       # Script to apply Terraform configurations
└── README.md                          # Project documentation
```

## Prerequisites

Before setting up the project, ensure you have the following:

- **Azure Account:** An active Azure subscription.
- **Azure CLI:** Installed on your local machine. [Install Azure CLI](https://docs.microsoft.com/cli/azure/install-azure-cli)
- **GitHub Account:** With GitHub Actions enabled.
- **Terraform:** Installed if managing infrastructure as code. [Install Terraform](https://www.terraform.io/downloads)
- **Python 3.8+**
- **Git:** Installed for version control.

## Setup

1. **Fork the Repository:**

   Fork this repository to your own GitHub account.

2. **Clone the Repository:**

   ```bash
   git clone https://github.com/your-username/azure-mlops-random-regressor.git
   cd azure-mlops-random-regressor
   ```

3. **Configure GitHub Secrets:**

   In your GitHub repository, navigate to `Settings` > `Secrets and variables` > `Actions` > `New repository secret` and add the following secrets:

   - `AZURE_CREDENTIALS`: Azure Service Principal credentials in JSON format.
   - `AZURE_SUBSCRIPTION`: Your Azure subscription ID.
   - `ARM_CLIENT_ID`: Azure Service Principal client ID.
   - `ARM_CLIENT_SECRET`: Azure Service Principal client secret.
   - `ARM_SUBSCRIPTION_ID`: Your Azure subscription ID.
   - `ARM_TENANT_ID`: Your Azure tenant ID.

4. **Modify Configuration Files:**

   Update `config-infra-dev.yml` and `config-infra-prod.yml` with your specific environment settings as needed.

## Pipelines

### Training Pipeline

The training pipeline automates the process of data preparation, model training, evaluation, and registration.

- **Pipeline Configuration:** `mlops/azureml/train/pipeline.yml`

- **Steps:**
  1. **Data Preparation:** Cleans and preprocesses the data.
  2. **Model Training:** Trains a Random Regressor model.
  3. **Model Evaluation:** Evaluates model performance.
  4. **Model Registration:** Registers the model in Azure ML if it meets performance criteria.

- **Run the Training Pipeline:**

  ```bash
  ./run_training.sh
  ```

### Batch Deployment Pipeline

Deploys the trained model for batch inference.

- **Pipeline Configuration:** `mlops/azureml/deploy/batch/pipeline.yml`

- **Deploy the Batch Endpoint:**

  ```bash
  ./deploy_batch.sh
  ```

### Online Deployment Pipeline

Deploys the trained model as an online endpoint for real-time inference.

- **Pipeline Configuration:** `mlops/azureml/deploy/online/pipeline.yml`

- **Deploy the Online Endpoint:**

  ```bash
  ./deploy_endpoint.sh
  ```

## Infrastructure as Code

Azure infrastructure is managed using Terraform to ensure reproducibility and scalability.

- **Configuration Files:** Located in the `infrastructure/` directory.

- **Apply Infrastructure Configurations:**

  ```bash
  ./terraform.sh
  ```

  This script initializes Terraform, applies the configurations, and provisions the necessary Azure resources.

## Continuous Integration/Continuous Deployment (CI/CD)

Automate workflows and deployments using GitHub Actions.

- **Workflow Files:** Located in `.github/workflows/`

  - `tf-gha-deploy-infra.yml`: Deploys Azure infrastructure using Terraform.
  - `deploy-model-training-pipeline.yml`: Executes the training pipeline.
  - `deploy-online-endpoint-pipeline.yml`: Deploys the online endpoint.
  - `deploy-batch-endpoint-pipeline.yml`: Deploys the batch endpoint.
  - `codeql.yml`: Performs code quality and security analysis using CodeQL.

- **Triggering Workflows:**

  Workflows are automatically triggered on specific events such as pushes, pull requests, or manual triggers.

## Data

Manage and register datasets with Azure ML for consistent access across pipelines.

- **Directory:** `data/`

  - `taxi-batch.csv`: Data used for batch inference.
  - `taxi-data.csv`: Primary training data.
  - `taxi-request.json`: Sample request payload for online inference.

- **Registering Data with Azure ML:**

  Ensure datasets are properly registered and referenced in the training pipeline configuration (`data.yml`).

## Model Development

Develop and manage model code within the `data-science/` directory.

- **Source Code:** `data-science/src/`

  - `prep.py`: Prepares and cleans the data.
  - `train.py`: Trains the Random Regressor model.
  - `evaluate.py`: Evaluates model performance.
  - `register.py`: Registers the trained model with Azure ML.

- **Environment Configuration:** `data-science/environment/train-conda.yml`

  Defines the Python environment required for training, including dependencies and versions.

## Environment

Set up the Python environment for development and training.

1. **Create Conda Environment:**

   ```bash
   conda env create -f data-science/environment/train-conda.yml
   ```

2. **Activate the Environment:**

   ```bash
   conda activate <environment-name>
   ```

3. **Install Additional Dependencies:**

   ```bash
   pip install -r requirements.txt
   ```

## Contributing

Contributions are welcome! Follow these steps to contribute:

1. **Fork the Repository:**

   Click the "Fork" button at the top right of this page to create your own fork.

2. **Clone Your Fork:**

   ```bash
   git clone https://github.com/your-username/azure-mlops-random-regressor.git
   cd azure-mlops-random-regressor
   ```

3. **Create a New Branch:**

   ```bash
   git checkout -b feature/your-feature-name
   ```

4. **Make Your Changes:**

   Implement your feature or bug fix.

5. **Commit Your Changes:**

   ```bash
   git commit -m "Description of your changes"
   ```

6. **Push to Your Fork:**

   ```bash
   git push origin feature/your-feature-name
   ```

7. **Open a Pull Request:**

   Navigate to the original repository and open a pull request from your fork.

## License

This project is licensed under the [MIT License](LICENSE).

---
