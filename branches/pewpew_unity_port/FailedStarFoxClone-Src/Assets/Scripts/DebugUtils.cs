#define DEBUG

using UnityEngine;
using System;

public class DebugUtils
{
    public static void Assert(bool condition)
    {
#if DEBUG
        if (!condition)
        {
            System.Diagnostics.StackTrace trace = new System.Diagnostics.StackTrace();
            Debug.LogWarning("Assert in method: " + trace.GetFrame(1).GetMethod().Name);

            throw new Exception();
        }
#endif
    }

    public static void Assert(bool condition, string message)
    {
#if DEBUG
        if (!condition)
        {
            Debug.LogError(message);

            System.Diagnostics.StackTrace trace = new System.Diagnostics.StackTrace();
            Debug.LogWarning("Assert in method: " + trace.GetFrame(1).GetMethod().Name);

            throw new Exception();
        }
#endif
    }
}