#!/bin/bash

# CrediTrust AI - Explainable Credit Risk Management
# Start Script for macOS / Linux

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo "==================================================="
echo "Starting CrediTrust AI (Backend + Frontend)"
echo "==================================================="

# Check for python command
if command -v python3 &>/dev/null; then
    PYTHON_CMD="python3"
elif command -v python &>/dev/null; then
    PYTHON_CMD="python"
else
    echo "Error: Python is not installed or not in PATH."
    exit 1
fi

echo "[1/2] Starting Python ML & SHAP API Server on port 8000..."
cd "$DIR"
$PYTHON_CMD server.py &
BACKEND_PID=$!

echo "[2/2] Starting React Vite Frontend on port 3000..."
cd "$DIR/frontend"
npm run dev &
FRONTEND_PID=$!

echo ""
echo "==================================================="
echo "Both servers are starting!"
echo "- Web Frontend:  http://localhost:3000/"
echo "- Backend API:   http://localhost:8000/"
echo "==================================================="
echo "Press Ctrl+C to stop both servers."

trap "kill $BACKEND_PID $FRONTEND_PID 2>/dev/null; exit" SIGINT SIGTERM

wait
