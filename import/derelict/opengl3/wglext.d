/*

Boost Software License - Version 1.0 - August 17th, 2003

Permission is hereby granted, free of charge, to any person or organization
obtaining a copy of the software and accompanying documentation covered by
this license (the "Software") to use, reproduce, display, distribute,
execute, and transmit the Software, and to prepare derivative works of the
Software, and to permit third-parties to whom the Software is furnished to
do so, all subject to the following:

The copyright notices in the Software and this entire statement, including
the above license grant, this restriction and the following disclaimer,
must be included in all copies of the Software, in whole or in part, and
all derivative works of the Software, unless such copies or derivative
works are solely in the form of machine-executable object code generated by
a source language processor.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT. IN NO EVENT
SHALL THE COPYRIGHT HOLDERS OR ANYONE DISTRIBUTING THE SOFTWARE BE LIABLE
FOR ANY DAMAGES OR OTHER LIABILITY, WHETHER IN CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.

*/

module derelict.opengl3.wglext;

version( Windows )
{
    private
    {
        import std.conv;
        import std.string;

        import derelict.util.wintypes;
        import derelict.opengl3.types;
        import derelict.opengl3.wgl;
        import derelict.opengl3.internal;
    }

    enum
    {
        // WGL_ARB_buffer_region
        WGL_FRONT_COLOR_BUFFER_BIT_ARB    = 0x00000001,
        WGL_BACK_COLOR_BUFFER_BIT_ARB     = 0x00000002,
        WGL_DEPTH_BUFFER_BIT_ARB          = 0x00000004,
        WGL_STENCIL_BUFFER_BIT_ARB        = 0x00000008,

        // WGL_ARB_create_context
        WGL_CONTEXT_DEBUG_BIT_ARB               = 0x0001,
        WGL_CONTEXT_FORWARD_COMPATIBLE_BIT_ARB  = 0x0002,
        WGL_CONTEXT_MAJOR_VERSION_ARB           = 0x2091,
        WGL_CONTEXT_MINOR_VERSION_ARB           = 0x2092,
        WGL_CONTEXT_LAYER_PLANE_ARB             = 0x2093,
        WGL_CONTEXT_FLAGS_ARB                   = 0x2094,
        ERROR_INVALID_VERSION_ARB               = 0x2095,

        // WGL_ARB_create_context_profile
        WGL_CONTEXT_PROFILE_MASK_ARB      = 0x9126,
        WGL_CONTEXT_CORE_PROFILE_BIT_ARB  = 0x00000001,
        WGL_CONTEXT_COMPATIBILITY_PROFILE_BIT_ARB = 0x00000002,
        ERROR_INVALID_PROFILE_ARB         = 0x2096,

        // WGL_ARB_create_context_robustness
        WGL_CONTEXT_ROBUST_ACCESS_BIT_ARB = 0x00000004,
        WGL_LOSE_CONTEXT_ON_RESET_ARB     = 0x8252,
        WGL_CONTEXT_RESET_NOTIFICATION_STRATEGY_ARB = 0x8256,
        WGL_NO_RESET_NOTIFICATION_ARB     = 0x8261,

        // WGL_ARB_framebuffer_sRGB
        WGL_FRAMEBUFFER_SRGB_CAPABLE_ARB  = 0x20A9,

        // WGL_ARB_make_current_read
        ERROR_INVALID_PIXEL_TYPE_ARB = 0x2043,
        ERROR_INCOMPATIBLE_DEVICE_CONTEXTS_ARB = 0x2054,

        // WGL_ARB_multisample
        WGL_SAMPLE_BUFFERS_ARB = 0x2041,
        WGL_SAMPLES_ARB = 0x2042,

        // WGL_ARB_pbuffer
        WGL_DRAW_TO_PBUFFER_ARB           = 0x202D,
        WGL_MAX_PBUFFER_PIXELS_ARB        = 0x202E,
        WGL_MAX_PBUFFER_WIDTH_ARB         = 0x202F,
        WGL_MAX_PBUFFER_HEIGHT_ARB        = 0x2030,
        WGL_PBUFFER_LARGEST_ARB           = 0x2033,
        WGL_PBUFFER_WIDTH_ARB             = 0x2034,
        WGL_PBUFFER_HEIGHT_ARB            = 0x2035,
        WGL_PBUFFER_LOST_ARB              = 0x2036,

        // WGL_ARB_pixel_format
        WGL_NUMBER_PIXEL_FORMATS_ARB        = 0x2000,
        WGL_DRAW_TO_WINDOW_ARB              = 0x2001,
        WGL_DRAW_TO_BITMAP_ARB              = 0x2002,
        WGL_ACCELERATION_ARB                = 0x2003,
        WGL_NEED_PALETTE_ARB                = 0x2004,
        WGL_NEED_SYSTEM_PALETTE_ARB         = 0x2005,
        WGL_SWAP_LAYER_BUFFERS_ARB          = 0x2006,
        WGL_SWAP_METHOD_ARB                 = 0x2007,
        WGL_NUMBER_OVERLAYS_ARB             = 0x2008,
        WGL_NUMBER_UNDERLAYS_ARB            = 0x2009,
        WGL_TRANSPARENT_ARB                 = 0x200A,
        WGL_TRANSPARENT_RED_VALUE_ARB       = 0x2037,
        WGL_TRANSPARENT_GREEN_VALUE_ARB     = 0x2038,
        WGL_TRANSPARENT_BLUE_VALUE_ARB      = 0x2039,
        WGL_TRANSPARENT_ALPHA_VALUE_ARB     = 0x203A,
        WGL_TRANSPARENT_INDEX_VALUE_ARB     = 0x203B,
        WGL_SHARE_DEPTH_ARB                 = 0x200C,
        WGL_SHARE_STENCIL_ARB               = 0x200D,
        WGL_SHARE_ACCUM_ARB                 = 0x200E,
        WGL_SUPPORT_GDI_ARB                 = 0x200F,
        WGL_SUPPORT_OPENGL_ARB              = 0x2010,
        WGL_DOUBLE_BUFFER_ARB               = 0x2011,
        WGL_STEREO_ARB                      = 0x2012,
        WGL_PIXEL_TYPE_ARB                  = 0x2013,
        WGL_COLOR_BITS_ARB                  = 0x2014,
        WGL_RED_BITS_ARB                    = 0x2015,
        WGL_RED_SHIFT_ARB                   = 0x2016,
        WGL_GREEN_BITS_ARB                  = 0x2017,
        WGL_GREEN_SHIFT_ARB                 = 0x2018,
        WGL_BLUE_BITS_ARB                   = 0x2019,
        WGL_BLUE_SHIFT_ARB                  = 0x201A,
        WGL_ALPHA_BITS_ARB                  = 0x201B,
        WGL_ALPHA_SHIFT_ARB                 = 0x201C,
        WGL_ACCUM_BITS_ARB                  = 0x201D,
        WGL_ACCUM_RED_BITS_ARB              = 0x201E,
        WGL_ACCUM_GREEN_BITS_ARB            = 0x201F,
        WGL_ACCUM_BLUE_BITS_ARB             = 0x2020,
        WGL_ACCUM_ALPHA_BITS_ARB            = 0x2021,
        WGL_DEPTH_BITS_ARB                  = 0x2022,
        WGL_STENCIL_BITS_ARB                = 0x2023,
        WGL_AUX_BUFFERS_ARB                 = 0x2024,
        WGL_NO_ACCELERATION_ARB             = 0x2025,
        WGL_GENERIC_ACCELERATION_ARB        = 0x2026,
        WGL_FULL_ACCELERATION_ARB           = 0x2027,
        WGL_SWAP_EXCHANGE_ARB               = 0x2028,
        WGL_SWAP_COPY_ARB                   = 0x2029,
        WGL_SWAP_UNDEFINED_ARB              = 0x202A,
        WGL_TYPE_RGBA_ARB                   = 0x202B,
        WGL_TYPE_COLORINDEX_ARB             = 0x202C,

        // WGL_ARB_pixel_format_float
        WGL_TYPE_RGBA_FLOAT_ARB = 0x21A0,

        // WGL_ARB_render_texture
        WGL_BIND_TO_TEXTURE_RGB_ARB       = 0x2070,
        WGL_BIND_TO_TEXTURE_RGBA_ARB      = 0x2071,
        WGL_TEXTURE_FORMAT_ARB            = 0x2072,
        WGL_TEXTURE_TARGET_ARB            = 0x2073,
        WGL_MIPMAP_TEXTURE_ARB            = 0x2074,
        WGL_TEXTURE_RGB_ARB               = 0x2075,
        WGL_TEXTURE_RGBA_ARB              = 0x2076,
        WGL_NO_TEXTURE_ARB                = 0x2077,
        WGL_TEXTURE_CUBE_MAP_ARB          = 0x2078,
        WGL_TEXTURE_1D_ARB                = 0x2079,
        WGL_TEXTURE_2D_ARB                = 0x207A,
        WGL_MIPMAP_LEVEL_ARB              = 0x207B,
        WGL_CUBE_MAP_FACE_ARB             = 0x207C,
        WGL_TEXTURE_CUBE_MAP_POSITIVE_X_ARB = 0x207D,
        WGL_TEXTURE_CUBE_MAP_NEGATIVE_X_ARB = 0x207E,
        WGL_TEXTURE_CUBE_MAP_POSITIVE_Y_ARB = 0x207F,
        WGL_TEXTURE_CUBE_MAP_NEGATIVE_Y_ARB = 0x2080,
        WGL_TEXTURE_CUBE_MAP_POSITIVE_Z_ARB = 0x2081,
        WGL_TEXTURE_CUBE_MAP_NEGATIVE_Z_ARB = 0x2082,
        WGL_FRONT_LEFT_ARB                = 0x2083,
        WGL_FRONT_RIGHT_ARB               = 0x2084,
        WGL_BACK_LEFT_ARB                 = 0x2085,
        WGL_BACK_RIGHT_ARB                = 0x2086,
        WGL_AUX0_ARB                      = 0x2087,
        WGL_AUX1_ARB                      = 0x2088,
        WGL_AUX2_ARB                      = 0x2089,
        WGL_AUX3_ARB                      = 0x208A,
        WGL_AUX4_ARB                      = 0x208B,
        WGL_AUX5_ARB                      = 0x208C,
        WGL_AUX6_ARB                      = 0x208D,
        WGL_AUX7_ARB                      = 0x208E,
        WGL_AUX8_ARB                      = 0x208F,
        WGL_AUX9_ARB                      = 0x2090,
    }

    alias HANDLE HPBUFFERARB;

    extern(Windows) nothrow
    {
        // WGL_ARB_extensions_string
        alias const(char*) function(HDC) da_wglGetExtensionsStringARB;

        // WGL_ARB_buffer_region
        alias HANDLE function(HDC, int, UINT) da_wglCreateBufferRegionARB;
        alias void function(HANDLE) da_wglDeleteBufferRegionARB;
        alias BOOL function(HANDLE, int, int, int, int) da_wglSaveBufferRegionARB;
        alias BOOL function(HANDLE, int, int, int, int, int, int) da_wglRestoreBufferRegionARB;

        // WGL_ARB_create_context
        alias HGLRC function(HDC, HGLRC, const(int)*) da_wglCreateContextAttribsARB;

        // WGL_ARB_make_current_read
        alias BOOL function(HDC, HDC, HGLRC) da_wglMakeContextCurrentARB;
        alias HDC function() da_wglGetCurrentReadDCARB;

        // WGL_ARB_pbuffer
        alias HPBUFFERARB function(HDC, int, int, int, const(int)*) da_wglCreatePbufferARB;
        alias HDC function(HPBUFFERARB) da_wglGetPbufferDCARB;
        alias int function(HPBUFFERARB, HDC) da_wglReleasePbufferDCARB;
        alias BOOL function(HPBUFFERARB) da_wglDestroyPbufferARB;
        alias BOOL function(HPBUFFERARB, int, int) da_wglQueryPbufferARB;

        // WGL_ARB_pixel_format
        alias BOOL function(HDC, int, int, UINT, const(int)*, int*) da_wglGetPixelFormatAttribivARB;
        alias BOOL function(HDC, int, int, UINT, const(int)*, FLOAT*) da_wglGetPixelFormatAttribfvARB;
        alias BOOL function(HDC, const(int)*, const(FLOAT)*, UINT, int*, UINT*) da_wglChoosePixelFormatARB;

        // WGL_ARB_render_texture
        alias BOOL function(HPBUFFERARB, int) da_wglBindTexImageARB;
        alias BOOL function(HPBUFFERARB, int) da_wglReleaseTexImageARB;
        alias BOOL function(HPBUFFERARB, const(int)*) da_wglSetPbufferAttribARB;

    }

    __gshared
    {
        da_wglGetExtensionsStringARB wglGetExtensionsStringARB;
        da_wglCreateBufferRegionARB wglCreateBufferRegionARB;
        da_wglDeleteBufferRegionARB wglDeleteBufferRegionARB;
        da_wglSaveBufferRegionARB wglSaveBufferRegionARB;
        da_wglRestoreBufferRegionARB wglRestoreBufferRegionARB;
        da_wglCreateContextAttribsARB wglCreateContextAttribsARB;
        da_wglMakeContextCurrentARB wglMakeContextCurrentARB;
        da_wglGetCurrentReadDCARB wglGetCurrentReadDCARB;
        da_wglCreatePbufferARB wglCreatePbufferARB;
        da_wglGetPbufferDCARB wglGetPbufferDCARB;
        da_wglReleasePbufferDCARB wglReleasePbufferDCARB;
        da_wglDestroyPbufferARB wglDestroyPbufferARB;
        da_wglQueryPbufferARB wglQueryPbufferARB;
        da_wglGetPixelFormatAttribivARB wglGetPixelFormatAttribivARB;
        da_wglGetPixelFormatAttribfvARB wglGetPixelFormatAttribfvARB;
        da_wglChoosePixelFormatARB wglChoosePixelFormatARB;
        da_wglBindTexImageARB wglBindTexImageARB;
        da_wglReleaseTexImageARB wglReleaseTexImageARB;
        da_wglSetPbufferAttribARB wglSetPbufferAttribARB;
    }

    private __gshared {
        bool _WGL_ARB_extensions_string;
        bool _WGL_ARB_buffer_region;
        bool _WGL_ARB_create_context;
        bool _WGL_ARB_create_context_profile;
        bool _WGL_ARB_create_context_robustness;
        bool _WGL_ARB_framebuffer_sRGB;
        bool _WGL_ARB_make_current_read;
        bool _WGL_ARB_multisample;
        bool _WGL_ARB_pbuffer;
        bool _WGL_ARB_pixel_format;
        bool _WGL_ARB_pixel_format_float;
        bool _WGL_ARB_render_texture;
        bool _WGL_ARB_robustness_application_isolation;
        bool _WGL_ARB_robustness_share_group_isolation;
    }

    bool WGL_ARB_extensions_string() @property { return _WGL_ARB_extensions_string; }
    bool WGL_ARB_buffer_region() @property { return _WGL_ARB_buffer_region; }
    bool WGL_ARB_create_context() @property { return _WGL_ARB_create_context; }
    bool WGL_ARB_create_context_profile() @property { return _WGL_ARB_create_context_profile; }
    bool WGL_ARB_create_context_robustness() @property { return _WGL_ARB_create_context_robustness; }
    bool WGL_ARB_framebuffer_sRGB() @property { return _WGL_ARB_framebuffer_sRGB; }
    bool WGL_ARB_make_current_read() @property { return _WGL_ARB_make_current_read; }
    bool WGL_ARB_multisample() @property { return _WGL_ARB_multisample; }
    bool WGL_ARB_pbuffer() @property { return _WGL_ARB_pbuffer; }
    bool WGL_ARB_pixel_format() @property { return _WGL_ARB_pixel_format; }
    bool WGL_ARB_pixel_format_float() @property { return _WGL_ARB_pixel_format_float; }
    bool WGL_ARB_render_texture() @property { return _WGL_ARB_render_texture; }
    bool WGL_ARB_robustness_application_isolation() @property { return _WGL_ARB_robustness_application_isolation; }
    bool WGL_ARB_robustness_share_group_isolation() @property { return _WGL_ARB_robustness_share_group_isolation; }

    private bool isWGLExtSupported(string name)
    {
        static string extstr;
        if( extstr == null ) extstr = to!string(wglGetExtensionsStringARB(wglGetCurrentDC()));

        auto index = extstr.indexOf(name);
        if(index != -1)
        {
            // It's possible that the extension name is actually a
            // substring of another extension. If not, then the
            // character following the name in the extenions string
            // should be a space (or possibly the null character).
            size_t idx = index + name.length;
            if(extstr[idx] == ' ' || extstr[idx] == '\0')
                return true;
        }

        return false;
    }

    package void loadPlatformEXT( GLVersion glversion )
    {
        // This needs to be loaded first. If it fails to load, just abort.
        wglGetExtensionsStringARB = cast( da_wglGetExtensionsStringARB ) loadGLFunc( "wglGetExtensionsStringARB" );
        if( !wglGetExtensionsStringARB ) return;

        if( isWGLExtSupported( "WGL_ARB_buffer_region" )) {
            try {
                bindGLFunc( cast(void**)&wglCreateBufferRegionARB, "wglCreateBufferRegionARB" );
                bindGLFunc( cast(void**)&wglDeleteBufferRegionARB, "wglDeleteBufferRegionARB" );
                bindGLFunc( cast(void**)&wglSaveBufferRegionARB, "wglSaveBufferRegionARB" );
                bindGLFunc( cast(void**)&wglRestoreBufferRegionARB, "wglRestoreBufferRegionARB" );
                _WGL_ARB_buffer_region = true;
            } catch( Exception e ) { _WGL_ARB_buffer_region = false; }
        }
        if( isWGLExtSupported( "WGL_ARB_create_context" )) {
            try {
                bindGLFunc( cast(void**)&wglCreateContextAttribsARB, "wglCreateContextAttribsARB" );
                _WGL_ARB_create_context = true;
            } catch( Exception e ) { _WGL_ARB_create_context = false; }
        }

        _WGL_ARB_create_context_profile = isWGLExtSupported( "WGL_ARB_create_context_profile" );
        _WGL_ARB_create_context_robustness = isWGLExtSupported( "WGL_ARB_create_context_robustness" );
        _WGL_ARB_framebuffer_sRGB = isWGLExtSupported( "WGL_ARB_framebuffer_sRGB" );

        if( isWGLExtSupported( "WGL_ARB_make_current_read" )) {
            try {
                bindGLFunc( cast(void**)&wglMakeContextCurrentARB, "wglMakeContextCurrentARB" );
                bindGLFunc( cast(void**)&wglGetCurrentReadDCARB, "wglGetCurrentReadDCARB" );
                _WGL_ARB_make_current_read = true;
            } catch( Exception e ) { _WGL_ARB_make_current_read = false; }
        }

        _WGL_ARB_multisample = isWGLExtSupported( "WGL_ARB_multisample" );

        if( isWGLExtSupported( "WGL_ARB_pbuffer" )) {
            try {
                bindGLFunc( cast(void**)&wglCreatePbufferARB, "wglCreatePbufferARB" );
                bindGLFunc( cast(void**)&wglGetPbufferDCARB, "wglGetPbufferDCARB" );
                bindGLFunc( cast(void**)&wglReleasePbufferDCARB, "wglReleasePbufferDCARB" );
                bindGLFunc( cast(void**)&wglDestroyPbufferARB, "wglDestroyPbufferARB" );
                bindGLFunc( cast(void**)&wglQueryPbufferARB, "wglQueryPbufferARB" );
                _WGL_ARB_pbuffer = true;
            } catch( Exception e ) { _WGL_ARB_pbuffer = false; }
        }
        if( isWGLExtSupported( "WGL_ARB_pixel_format" )) {
            try {
                bindGLFunc( cast(void**)&wglGetPixelFormatAttribivARB, "wglGetPixelFormatAttribivARB" );
                bindGLFunc( cast(void**)&wglGetPixelFormatAttribfvARB, "wglGetPixelFormatAttribfvARB" );
                bindGLFunc( cast(void**)&wglChoosePixelFormatARB, "wglChoosePixelFormatARB" );
                _WGL_ARB_pixel_format = true;
            } catch( Exception e ) { _WGL_ARB_pixel_format = false; }
        }

        _WGL_ARB_pixel_format_float = isWGLExtSupported( "WGL_ARB_pixel_format_float" );

        if( isWGLExtSupported( "WGL_ARB_render_texture" )) {
            try {
                bindGLFunc( cast(void**)&wglBindTexImageARB, "wglBindTexImageARB" );
                bindGLFunc( cast(void**)&wglReleaseTexImageARB, "wglReleaseTexImageARB" );
                bindGLFunc( cast(void**)&wglSetPbufferAttribARB, "wglSetPbufferAttribARB" );
                _WGL_ARB_render_texture = true;
            } catch( Exception e ) { _WGL_ARB_render_texture = false; }
        }

        _WGL_ARB_robustness_application_isolation = isWGLExtSupported( "WGL_ARB_robustness_application_isolation" );
        _WGL_ARB_robustness_share_group_isolation = isWGLExtSupported( "WGL_ARB_robustness_share_group_isolation" );
    }
}