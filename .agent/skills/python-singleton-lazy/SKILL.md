---
name: python-singleton-lazy
description: Implement Python classes using a simple Singleton pattern with Lazy Loading (No Locks).
author: Antigravity
version: 1.0.1
---

# Python Simple Singleton with Lazy Loading

Use this pattern for a lightweight, lazy-loaded Singleton. This version does **not** use Thread Locking, making it faster and simpler for single-threaded applications or when thread safety is handled elsewhere.

## Implementation

We use a simple class method `get_instance` to check if the instance exists. If not, it creates it.

```python
from typing import Optional, Any

class ServiceName:
    """
    Singleton class for [Service Description] with simple lazy loading.
    """
    _instance: Optional['ServiceName'] = None

    def __init__(self):
        """
        Private constructor. Do not call directly.
        Use ServiceName.get_instance() instead.
        """
        if ServiceName._instance is not None:
             raise RuntimeError("Call get_instance() instead")
        
        # --- Initialization Logic Here ---
        print("Initializing ServiceName...")
        # ---------------------------------

    @classmethod
    def get_instance(cls) -> 'ServiceName':
        """
        Static access method.
        Creates the instance only when first called.
        """
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

    def some_method(self) -> Any:
        """
        Example business logic method.
        """
        return "Task Completed"

# Usage Example:
# service = ServiceName.get_instance() # Initializes here
# service2 = ServiceName.get_instance() # Returns existing instance
```

## Checklist for AI
When applying this skill:
1.  [ ] Rename `ServiceName` to a meaningful class name.
2.  [ ] Define `_instance` as a class attribute acting as the cache.
3.  [ ] Implement `get_instance` with a simple `if is None` check.
4.  [ ] Prevent direct instantiation in `__init__`.
