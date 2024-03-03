# Repository iterator

Repository iterator is a tool designed to iterate through multiple projects in your repositories, facilitating vulnerability checks and other operations.

## Getting Started

1. **Ensure Node.js and NVM are installed**: Make sure you have Node.js installed on your system. You can use NVM (Node Version Manager) to manage your Node.js installations. Install NVM by following the instructions [here](https://github.com/nvm-sh/nvm#installing-and-updating).

2. **Perform Iterations**: After the setup is complete, you can perform iterations through your projects using the following commands:
    - To iterate through all projects listed in the `repositories.json` configuration file, run:

        ```bash
        ./main.sh --all
        ```

    - Alternatively, you can iterate through specific projects by specifying their keys from the `repositories.json` file. For example, to iterate through the "rep1" and "rep2" projects, run:

        ```bash
        ./main.sh --rep1 --rep2
        ```

    Ensure to run these commands within the project directory where you wish to perform iterations.

## Additional Notes

- **Task Execution**: When running the setup script, all tasks are executed within the script's process. This means changes made by the script, such as switching Node.js versions using `nvm use`, are contained within the script's environment and do not affect the terminal session where the script is executed.

- **Configuration File**: Projects must be added to the `repositories.json` configuration file. Ensure to specify the correct keys **(CamelCase only)** for your projects in this file.

## Project Structure

```
package-vulnerabilities/
├── main.js                           # Entry point/main script
├── README.md                         # Instructions for using the package
├── scripts/
│   └── helpers
|   |   └── helpers.sh                # Script with helper functions
|   |   └── setup_node_environment.sh # Script to set up the node environment
│   └── common                        # Directory containing common scripts
|       └── vulnerability_checker.sh  # Script to check vulnerabilities
|
|── configs/
│   └── config.sh                     # Main configuration
│   └── repositories.json             # Configuration file for repository paths
|
└── assets/
    └── colors.sh                     # ANSI color codes for text colors
```

This project structure organizes the files for easy management and usage.

If you encounter any issues or have questions, feel free to reach out [nhodi](mailto:f.gregorio.w@gmail.com).
