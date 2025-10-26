<?php
declare(strict_types=1);

namespace BlackCat\Database\Packages\LoginAttempts\Dto;

/**
 * Jednoduché, neměnné DTO s veřejnými readonly vlastnostmi.
 * - Bez logiky; pouze nosič dat.
 * - Silné typy drží kontrakt napříč vrstvami.
 */
final class LoginAttemptDto {
    public function __construct(
        public readonly ?int $id,
        public readonly string $ipHash,
        public readonly \DateTimeImmutable $attemptedAt,
        public readonly bool $success,
        public readonly ?int $userId,
        public readonly ?string $usernameHash,
        public readonly ?int $authEventId
    ) {}

    /** Vhodné pro serializaci/logování (bez velkých blobů). */
    public function toArray(): array {
        return get_object_vars($this);
    }
}
