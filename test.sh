#!/usr/bin/env bash

COUNT=5

echo "Test by value..."
go test ./... -bench=BenchmarkMemoryStack -benchmem -run=^$ -count=$COUNT > bench.txt && benchstat bench.txt
echo "-----------------------------------------------------------------------------------------------"

echo "Test by pointer..."
go test ./... -bench=BenchmarkMemoryHeap -benchmem -run=^$ -count=$COUNT > bench.txt && benchstat bench.txt
echo "-----------------------------------------------------------------------------------------------"


# Cleanup
rm bench.txt > /dev/null 2>&1
rm stack*.out > /dev/null 2>&1
rm heap*.out > /dev/null 2>&1
