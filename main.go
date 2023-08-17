package main

import (
	"github.com/youpy/go-wav"
	"os"
	"log"
)

func check(error error) {
	if (error != nil) {
		log.Fatal(error)	
	}
}

func main() {
	file, err := os.Open("distance.wav");
	check(err)
	reader := wav.NewReader(file)
	defer file.Close()

	log.Println(reader.Size)

	samples, err := reader.ReadSamples()
	
	for _, sample := range samples {
		log.Printf("L/R: %d/%d\n", reader.IntValue(sample, 0), reader.IntValue(sample, 1))
	}
}
