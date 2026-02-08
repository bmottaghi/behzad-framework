I'm using behzad-framework for systematic feature delivery.

**FIRST, read these framework documents (in this order):**
1. Read: philosophy.md - Understand the principles
2. Read: deliver-flow.md - The 9-phase delivery process
3. Read: decision-gates.md - The 5 approval points

**THEN, read the project documents:**
4. Read: docs/product-system.md - Current product state
5. Read: docs/tech-spine/ (all 5 files) - Technical knowledge
6. Read: docs/learning/lessons.md - Past lessons

**FEATURE REQUEST:**
I want to deliver: $ARGUMENTS

**FOLLOW THE 9-PHASE DELIVER FLOW:**

**Phase 1: Requirement Clarification**
- Act as Product Manager
- Ask clarifying questions about Who, What, Why, When, Where, How, Constraints
- Don't assume - ask specific questions
- Continue until requirements are clear

**Phase 2: Feature Definition**
- Create feature entry in docs/product-system.md
- Include: Feature ID (FEAT-XXX), Title, Description, Requirements, Acceptance Criteria, Priority, Dependencies, Status
- Requirements must be specific and testable
- **DECISION GATE 1:** Present feature definition and ask "Does this match what you want?"
- Wait for approval before continuing

**Phase 3: Technical Impact Analysis**
- Read tech-spine documents
- Analyze: affected components, new components, data changes, dependencies, risks
- Check lessons.md for relevant past lessons
- Document technical impact

**Phase 4: Execution Planning**
- Create phased plan in docs/execution/execution-plan.md
- Each phase: 1-4 hours, clear goal, specific scope, tests, checkpoint
- Phases must be resumable
- **DECISION GATE 2:** Present plan and ask "Should I proceed with this plan?"
- Wait for approval before continuing

**Phase 5: Implementation**
- Execute phase by phase
- Write tests alongside code
- Update tech-spine as you go
- Validate checkpoint after each phase
- Mark phases complete in execution-plan.md

**Phase 6: Pre-Release Review**
- Verify all acceptance criteria
- Run full test suite
- Confirm documentation updated
- Security and performance check
- **DECISION GATE 3:** Present review and ask "Ready to deploy?"

**Phase 7: Deployment**
- Deploy to staging first if applicable
- **DECISION GATE 4:** Ask "Ready to deploy to production?"
- Deploy to production
- Create release tag

**Phase 8: Post-Deployment Validation**
- Health check
- Smoke tests
- Monitor logs and metrics
- Validate feature works in production

**Phase 9: Learning Capture**
- Identify lessons learned
- Draft lessons in proper format
- **DECISION GATE 5:** Present lessons and ask "Should I add these lessons?"
- Update product-system.md status to "Completed"

**IMPORTANT RULES:**
- Stop at each decision gate and wait for explicit approval
- Never skip phases
- Keep documents updated as you go
- If blocked, explain and ask for guidance
