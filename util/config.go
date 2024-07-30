package util

import "os"

type Config struct {
	DBName      string
	DBHost      string
	DBPort      string
	DBUser      string
	DBPassword  string
	ServicePort string
}

func LoadConfig() (config Config, error error) {
	config.DBName = os.Getenv("DB_NAME")
	config.DBHost = os.Getenv("DB_HOST")
	config.DBPort = os.Getenv("DB_PORT")
	config.DBUser = os.Getenv("DB_USER")
	config.DBPassword = os.Getenv("DB_Password")
	config.ServicePort = os.Getenv("SERVICE_PORT")
	return
}
