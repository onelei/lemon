﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Lemon
{
    public class DontDestroyOnLoad : BaseBehavior
    {
        private void Awake()
        {
            CacheGameObject.isStatic = true;
            DontDestroyOnLoad(CacheGameObject);
        }
    }
}
