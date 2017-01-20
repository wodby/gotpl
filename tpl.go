package main

import (
	"io/ioutil"
	"log"
	"os"
	"strings"
	"text/template"
)

type Environment map[string]string

func check(e error) {
	if e != nil {
		panic(e)
	}
}

func parseEnvironment(environ []string) Environment {
	env := make(Environment)
	if len(environ) == 0 {
		return env
	}
	for _, e := range environ {
		kv := strings.Split(e, "=")
		env[kv[0]] = kv[1]
	}
	return env
}

func main() {
	buf, err := ioutil.ReadFile(os.Args[1])
	if err != nil {
		log.Fatalf("reading file: %s", err)
	}

	tpl, err := template.New("titleTest").Funcs(newFuncMap()).Parse(string(buf))
	if err != nil {
		log.Fatalf("parsing: %s", err)
	}

	err = tpl.Execute(os.Stdout, parseEnvironment(os.Environ()))
	if err != nil {
		panic(err)
	}
}
