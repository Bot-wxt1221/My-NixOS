{ config, lib, pkgs, ... }:
{
  imports = [

  ];
  environment.systemPackages = [
    pkgs.xmrig
  ];
  services.xmrig.enable = true;
  services.xmrig.settings = ''{
    "api": {
        "id": null,
        "worker-id": null
    },
    "http": {
        "enabled": false,
        "host": "127.0.0.1",
        "port": 0,
        "access-token": null,
        "restricted": true
    },
    "autosave": true,
    "background": false,
    "colors": true,
    "title": true,
    "randomx": {
        "init": -1,
        "init-avx2": -1,
        "mode": "auto",
        "1gb-pages": true,
        "rdmsr": true,
        "wrmsr": true,
        "cache_qos": false,
        "numa": true,
        "scratchpad_prefetch_mode": 1
    },
    "cpu": {
        "enabled": true,
        "huge-pages": true,
        "huge-pages-jit": false,
        "hw-aes": null,
        "priority": null,
        "memory-pool": false,
        "yield": true,
        "asm": true,
        "argon2-impl": null,
        "argon2": [0, 6, 1, 7, 2, 8, 3, 9, 4, 10, 5, 11],
        "cn": [
            [1, 0],
            [1, 1],
            [1, 2],
            [1, 3],
            [1, 4],
            [1, 5]
        ],
        "cn-heavy": [
            [1, 0],
            [1, 1],
            [1, 2]
        ],
        "cn-lite": [
            [1, 0],
            [1, 6],
            [1, 1],
            [1, 7],
            [1, 2],
            [1, 8],
            [1, 3],
            [1, 9],
            [1, 4],
            [1, 10],
            [1, 5],
            [1, 11]
        ],
        "cn-pico": [
            [2, 0],
            [2, 6],
            [2, 1],
            [2, 7],
            [2, 2],
            [2, 8],
            [2, 3],
            [2, 9],
            [2, 4],
            [2, 10],
            [2, 5],
            [2, 11]
        ],
        "cn/upx2": [
            [2, 0],
            [2, 6],
            [2, 1],
            [2, 7],
            [2, 2],
            [2, 8],
            [2, 3],
            [2, 9],
            [2, 4],
            [2, 10],
            [2, 5],
            [2, 11]
        ],
        "ghostrider": [
            [8, 0],
            [8, 1],
            [8, 2],
            [8, 3],
            [8, 4],
            [8, 5]
        ],
        "rx": [0, 1, 2, 3, 4, 5],
        "rx/wow": [0, 6, 1, 7, 2, 8, 3, 9, 4, 10, 5, 11],
        "cn-lite/0": false,
        "cn/0": false,
        "rx/arq": "rx/wow",
        "rx/keva": "rx/wow"
    },
    "log-file": null,
    "donate-level": 1,
    "donate-over-proxy": 1,
    "pools": [
        {
            "coin": "monero",
            "algo": "rx/0",
            "url": "zeph.kryptex.network:8888",
            "user": "ZEPHYR2TBe6hELPtyzNESeREMtVrx3DziTDfftLfScPq66K8h7fUxNbQGouJXHhRxYjgiNsyVwGJ4QzQf15W7viTEFPwLEYV6PW4G/wxt",
            "pass": "x",
            "tls": true,
            "keepalive": true,
            "nicehash": false
        }
    ]
    "retries": 5,
    "retry-pause": 5,
    "print-time": 60,
    "dmi": true,
    "syslog": false,
    "tls": {
        "enabled": false,
        "protocols": null,
        "cert": null,
        "cert_key": null,
        "ciphers": null,
        "ciphersuites": null,
        "dhparam": null
    },
    "dns": {
        "ipv6": false,
        "ttl": 30
    },
    "user-agent": null,
    "verbose": 0,
    "watch": true,
    "pause-on-battery": false,
    "pause-on-active": false
}'';
}