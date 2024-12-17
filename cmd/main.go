package main

import (
	"fmt"
	"log"
	"os"
	"os/exec"
	"time"
)

func main() {
	influxHost := os.Getenv("INFLUX_HOST")
	influxToken := os.Getenv("INFLUX_TOKEN")
	influxBucket := os.Getenv("INFLUX_BUCKET")
	influxOrg := os.Getenv("INFLUX_ORG")

	backupBaseDir := "/tmp/influx-backup"
	date := time.Now().Format("2006-01-02")

	log.Println("Starting backup...")
	cmd := exec.Command(
		"influx", "backup",
		"--host", influxHost,
		"--token", influxToken,
		"--bucket", influxBucket,
		"--org", influxOrg,
		fmt.Sprintf("%s/%s", backupBaseDir, date),
	)

	output, err := cmd.CombinedOutput()
	if err != nil {
		log.Fatalf("Backup failed: %v\nOutput: %s", err, string(output))
	}

	log.Println("Backup completed successfully.")
}
