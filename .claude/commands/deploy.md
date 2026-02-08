I'm deploying feature: $ARGUMENTS

**PRE-DEPLOYMENT CHECKS:**
1. Read: docs/product-system.md - Verify feature exists and status
2. Read: docs/execution/execution-plan.md - All phases complete?
3. Read: docs/tech-spine/test-strategy.md - Test requirements met?

**VERIFY READINESS:**
```
Deployment Readiness Check: $ARGUMENTS

[ ] All phases completed
[ ] All tests passing
[ ] Tech-spine updated
[ ] Pre-release review done
[ ] Code review completed (if required)

Ready for deployment: Yes/No
```

**IF NOT READY:**
List what's missing and recommend next steps.

**IF READY - GATE 4:**
```
╔════════════════════════════════════════════════════════╗
║                    DECISION GATE 4                      ║
║                  PRODUCTION DEPLOYMENT                  ║
╠════════════════════════════════════════════════════════╣
║                                                         ║
║  Feature: $ARGUMENTS                                    ║
║  All checks passed. Ready for production.               ║
║                                                         ║
║  Options:                                               ║
║  1. APPROVE - Deploy to production                      ║
║  2. DELAY - Schedule for later                          ║
║  3. REJECT - Need more work (specify what)              ║
║                                                         ║
╚════════════════════════════════════════════════════════╝
```

**AFTER APPROVAL:**
1. Execute deployment steps
2. Update product-system.md status to "Deployed"
3. Tag version in git
4. Proceed to Phase 8: Post-Deployment Validation
