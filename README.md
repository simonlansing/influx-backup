# InfluxDB Backup CLI Tool
This is a simple CLI tool written in Go to create backups of an InfluxDB instance. It utilizes the influx CLI tool and runs a backup command with the provided environment variables for configuration.

## Features
- Backs up InfluxDB data for a specified bucket and organization.
- Saves backups in a timestamped directory for better organization.
- Simple configuration using environment variables.

## Installation

### Prerequisites
1. **InfluxDB CLI:** Ensure the influx CLI is installed and available in your system's PATH. You can find installation instructions here.
2. **Go:** Install Go from the official website.

### Build the Tool
1. Clone this repository:

```bash
git clone https://github.com/your-repo/influxdb-backup.git
cd influxdb-backup
```

2. Build the CLI tool:

```bash
go build -o influxdb-backup
```

## Usage

### Configuration

The tool requires the following environment variables to be set:

| Variable      | Description                                   | Example Value         |
| ------------- | --------------------------------------------- | --------------------- |
| INFLUX_HOST   | The host of the InfluxDB instance.            | http://localhost:8086 |
| INFLUX_TOKEN  | The token for authentication.                 | my-super-secret-token |
| INFLUX_BUCKET | The bucket to back up.                        | example-bucket        |
| INFLUX_ORG    | The organization to which the bucket belongs. | example-org           |

You can set these variables in your terminal:

```bash
export INFLUX_HOST="http://localhost:8086"
export INFLUX_TOKEN="my-super-secret-token"
export INFLUX_BUCKET="example-bucket"
export INFLUX_ORG="example-org"
```


### Running the Backup
Run the tool:

```bash
./influxdb-backup
```

The backup will be stored in a timestamped directory under /tmp/influx-backup. For example:

```bash
/tmp/influx-backup/2024-12-18/
```

## Development

### Testing Locally

You can run the tool locally without building a binary:

```bash
go run main.go
```

### Directory Structure

The backup files are stored in:

```bash
/tmp/influx-backup/<YYYY-MM-DD>/
```

## License

This project is licensed under the MIT License.

## Contributions

Contributions are welcome! Feel free to open issues or submit pull requests to improve the tool.