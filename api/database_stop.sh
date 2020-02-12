#!/bin/bash

pid=$(pgrep mongo)
kill $pid