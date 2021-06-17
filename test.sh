#!/usr/bin/env bash

COUNT=5

echo "Return by value..."
go test ./... -bench=BenchmarkMemoryStack -benchmem -run=^$ -count=$COUNT > bench.txt && benchstat bench.txt
echo "-----------------------------------------------------------------------------------------------"
echo "Return by pointer..."
go test ./... -bench=BenchmarkMemoryHeap -benchmem -run=^$ -count=$COUNT > bench.txt && benchstat bench.txt
echo "-----------------------------------------------------------------------------------------------"

echo "Pass struct by value..."
go test ./... -bench=BenchmarkMemoryStackArg -benchmem -run=^$ -count=$COUNT > bench.txt && benchstat bench.txt
echo "-----------------------------------------------------------------------------------------------"
echo "Pass by pointer..."
go test ./... -bench=BenchmarkMemoryHeapArg -benchmem -run=^$ -count=$COUNT > bench.txt && benchstat bench.txt

# Cleanup
rm bench.txt > /dev/null 2>&1
rm stack*.out > /dev/null 2>&1
rm heap*.out > /dev/null 2>&1
