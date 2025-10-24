<?php
declare(strict_types=1);

namespace BlackCat\Database\Packages\LoginAttempts\Dto;

/**
 * Jednoduché, neměnné DTO s veřejnými readonly vlastnostmi.
 * - Žádná logika; pouze nosič dat.
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

    /** Vhodné pro serializaci/logování (bez binárních/velkých blobů). */
    public function toArray(): array {
        // get_object_vars funguje dobře s public readonly vlastnostmi
        return get_object_vars($this);
    }
}
