# APM Toolkit — Agentic Coding Philosophy

Agentic coding is the practice of building software that can reason, act, and adapt
using structured skills, metadata, and execution environments. APM Toolkit brings
agentic workflows to PowerShell by defining a standard way to package, validate,
and execute skills.

## What is a Skill?

A skill is a self-contained capability described by:

- SKILL.md — human-readable description
- skill.json — machine-readable metadata
- LICENSE — legal provenance
- .provenance — extraction and modification history

Skills are atomic. They can be packaged, shared, updated, and executed by agents.

## Why Agentic PowerShell?

PowerShell is uniquely suited for agentic workflows:

- It is object-oriented at the shell level.
- It integrates with Windows, Linux, and cloud environments.
- It can orchestrate tools, APIs, and local automation.
- It is already used in enterprise automation.

APM Toolkit extends PowerShell into the agentic domain.

## Core Concepts

### 1. Packaging
Skills must be reproducible, portable, and versioned.

### 2. Provenance
Every skill must track where it came from, how it was modified, and by whom.

### 3. Metadata
Agents require structured metadata to reason about capabilities.

### 4. Execution
Skills can be invoked by agents, scripts, or other skills.

## Goals of APM Toolkit

- Provide a standard skill format.
- Enable shallow Git extraction with provenance.
- Validate skill structure and metadata.
- Convert skills into agent-ready formats.
- Support future MCP server integration.

APM Toolkit is the foundation for agentic automation in PowerShell.
