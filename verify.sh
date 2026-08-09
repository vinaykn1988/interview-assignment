#!/bin/bash
#
# Verify that the interview environment is running correctly.
# Run this after: docker compose up -d --wait
#

echo "=== Environment Verification ==="
echo ""

PASS=0
FAIL=0

# Check Docker containers
echo "Checking Docker containers..."
if docker compose ps --status running 2>/dev/null | grep -q "interview-assignment-2-backend"; then
    echo "  [OK] Backend container is running"
    PASS=$((PASS + 1))
else
    echo "  [FAIL] Backend container is not running"
    FAIL=$((FAIL + 1))
fi

if docker compose ps --status running 2>/dev/null | grep -q "interview-assignment-2-frontend"; then
    echo "  [OK] Frontend container is running"
    PASS=$((PASS + 1))
else
    echo "  [FAIL] Frontend container is not running"
    FAIL=$((FAIL + 1))
fi

echo ""
echo "Waiting for services to start..."
sleep 5

# Check Backend API
echo "Checking Backend API..."
BACKEND_PORT=$(docker compose port backend 8000 2>/dev/null | cut -d: -f2)
if [ -z "$BACKEND_PORT" ]; then
    echo "  [FAIL] Cannot determine backend port"
    FAIL=$((FAIL + 1))
else
    if curl -s -o /dev/null -w "%{http_code}" "http://localhost:${BACKEND_PORT}/api/health/" | grep -q "200"; then
        echo "  [OK] Backend API is responding (port $BACKEND_PORT)"
        PASS=$((PASS + 1))
    else
        echo "  [FAIL] Backend API is not responding on port $BACKEND_PORT"
        echo "  Tip: Check logs with: docker compose logs backend"
        FAIL=$((FAIL + 1))
    fi
fi

# Check Frontend
echo "Checking Frontend..."
FRONTEND_PORT=$(docker compose port frontend 3000 2>/dev/null | cut -d: -f2)
if [ -z "$FRONTEND_PORT" ]; then
    echo "  [FAIL] Cannot determine frontend port"
    FAIL=$((FAIL + 1))
else
    if curl -s -o /dev/null -w "%{http_code}" "http://localhost:${FRONTEND_PORT}" | grep -q "200"; then
        echo "  [OK] Frontend is responding (port $FRONTEND_PORT)"
        PASS=$((PASS + 1))
    else
        echo "  [FAIL] Frontend is not responding on port $FRONTEND_PORT (may still be starting — wait 1-2 min and retry)"
        echo "  Tip: Check logs with: docker compose logs frontend"
        FAIL=$((FAIL + 1))
    fi
fi

# Check Jupyter
echo "Checking Jupyter..."
JUPYTER_PORT=$(docker compose port backend 8888 2>/dev/null | cut -d: -f2)
if [ -z "$JUPYTER_PORT" ]; then
    echo "  [FAIL] Cannot determine Jupyter port"
    FAIL=$((FAIL + 1))
else
    if curl -s -o /dev/null -w "%{http_code}" -L "http://localhost:${JUPYTER_PORT}" | grep -q "200"; then
        echo "  [OK] Jupyter is responding (port $JUPYTER_PORT)"
        PASS=$((PASS + 1))
    else
        echo "  [FAIL] Jupyter is not responding on port $JUPYTER_PORT"
        echo "  Tip: Check logs with: docker compose logs backend"
        FAIL=$((FAIL + 1))
    fi
fi

echo ""
echo "=== Results: $PASS passed, $FAIL failed ==="

if [ $FAIL -eq 0 ]; then
    echo ""
    echo "All checks passed! Your environment is ready."
else
    echo ""
    echo "Some checks failed. Please troubleshoot and re-run this script."
fi
